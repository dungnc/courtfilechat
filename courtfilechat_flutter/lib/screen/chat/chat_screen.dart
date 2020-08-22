import 'dart:async';
import 'dart:io';
import 'package:common/bloc/app_bloc.dart';
import 'package:common/bloc/chat_bloc.dart';
import 'package:common/model/message.dart';
import 'package:common/model/search_context.dart';
import 'package:courtfilechat_flutter/api/chat_service_api.dart';
import 'package:courtfilechat_flutter/bloc_provider/app_provider.dart';
import 'package:courtfilechat_flutter/bloc_provider/chat_provider.dart';
import 'package:courtfilechat_flutter/bloc_provider/context_provider.dart';
import 'package:courtfilechat_flutter/bloc_provider/dialogflow_provider.dart';
import 'package:courtfilechat_flutter/bloc_provider/search_context_provider.dart';
import 'package:courtfilechat_flutter/screen/chat/models/proxy_message.dart';
import 'package:courtfilechat_flutter/util/custom_colors.dart';
import 'package:courtfilechat_flutter/util/memory_management.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toast_pk/flutter_toast_pk.dart';

class Chat extends StatelessWidget {
  final String receiverId;
  final String receiverPhoto;
  final String receiverName;

  Chat(
      {Key key,
      @required this.receiverName,
      @required this.receiverId,
      this.receiverPhoto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          receiverName,
          style: TextStyle(
              color: CustomColors.whiteColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: ChatProvider(
        child: new ChatScreen(
          receiverId: receiverId,
          receiverPhoto: receiverPhoto,
          appBloc: AppProvider.of(context).appBloC,
        ),
        chatBloc: ChatBloc(ChatServiceApi()),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String receiverPhoto;
  final AppBloC appBloc;
  ChatScreen(
      {Key key, @required this.receiverId, this.receiverPhoto, this.appBloc})
      : super(key: key);

  @override
  State createState() =>
      new ChatScreenState(receiverId: receiverId, receiverPhoto: receiverPhoto);
}

class ChatScreenState extends State<ChatScreen> {
  ChatScreenState(
      {Key key, @required this.receiverId, @required this.receiverPhoto});

  BuildContext buildContext;

  String receiverId; // contextId of firestore context collection
  String receiverPhoto;
  String receiverName;
  String id;

  String chatId;

  List<Message> listMessage;
  String groupChatId;

  File imageFile;
  bool isLoading;
  String imageUrl;
  bool isDialogFlowResponsing;
  bool isChatStart;
  // int _partySelectedPos = -1;

  String _caseNumber;
  String _countyName;

  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();
  final FocusNode focusNode = new FocusNode();

  ChatBloc chatBloc;
  DialogFlowProvider dialogFlowProvider;
  SearchContextProvider searchContextProvider;
  ContextProvider contextProvider = new ContextProvider();

  var _lastInputValue = '';
  // final ValueChanged<String> _textChangeListener = (value) {
  //     String currentInputValue = value ?? '';
  //     if (currentInputValue.length < _lastInputValue.length){

  //     }
  // };
  _compareValue(String oldValue, String newValue) {
    _lastInputValue = newValue;
  }

  @override
  void initState() {
    super.initState();

    groupChatId = '';

    isLoading = false;
    isDialogFlowResponsing = false;
    isChatStart = false;
    imageUrl = '';
    readLocal();

  }

  @override
  void dispose() {
    textEditingController.dispose();

    super.dispose();
  }

  void getChatId(String contextId) async {
    print("========");
    print(contextId);

    chatBloc.getContextChatId(contextId).then((String chatId) {
      this.chatId = chatId;
      groupChatId = chatId;
      setState(() {});
    });
  }

  void readLocal() async {
    id = MemoryManagement.getUserId() ?? '';
    /*if (id.hashCode <= receiverId.hashCode) {
      groupChatId = '$id-$receiverId';
    } else {
      groupChatId = '$receiverId-$id';
    }*/

    setState(() {});
  }

  void _sendDialogFlowMessage(String message) {
    new Future.delayed(const Duration(milliseconds: 600)).then((data) {
      if (!isChatStart) {
        isDialogFlowResponsing = true;
        setState(() {});
      }

      dialogFlowProvider.dialogFlowBloc
          .sendQuery(id, message)
          .then((data) async {
        print('sendQuery data:  $data');
        _sendFlowMessage(data['result']['speech'], "message");
        _checkAndCallApi(data['result']);
      }).catchError((error) {});
    });
  }

  _checkAndCallApi(Map<String, dynamic> data) {
    var parameters = data['parameters'];
    String speechQuery = data['speech'];
    if (parameters != null) {
      String caseNumber = parameters['caseNumber'];
      List countyName = parameters['countyName'];
      if (speechQuery.toLowerCase().contains("we are searching")) {
        if (countyName != null && countyName.length > 0) {
          if (caseNumber != null && caseNumber.isNotEmpty) {
            // mean have parameter

            _caseNumber = caseNumber;
            _countyName = countyName[0];

            widget.appBloc
                .searchCaseService(
                    trackingID: caseNumber, courtOrganizationId: countyName[0])
                .then((data) {
              print('apiData $data');
              _sendFlowMessage(data, "info");

              /*SearchContext searchContext = new SearchContext();
              searchContext.context = "search-case";
              searchContext.content = data;
              searchContext.status = "pending";

              searchContextProvider.searchContextBloc.setSearchContext(groupChatId, searchContext);*/

              contextProvider.contextBloc.updateContextFiling(receiverId, data);

            }).catchError((error) {
              print('Error $error');
            });
          }
        }
      }
    }

    if (speechQuery.toLowerCase().contains("we are finding party")) {
      widget.appBloc
          .searchCaseService(
              trackingID: _caseNumber, courtOrganizationId: _countyName)
          .then((data) {
        _sendFlowMessage(data, "party");
      }).catchError((error) {
        print('Error $error');
      });
    }
  }

  Future getImage() async {
    /*File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        imageFile = image;
        isLoading = true;
      });
    }
    uploadFile();*/
  }

  Future uploadFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putFile(imageFile);

//    Uri downloadUrl = (await uploadTask.future).downloadUrl;
//    imageUrl = downloadUrl.toString();

    setState(() {
      isLoading = false;
    });

    onSendMessage(imageUrl, 1);
  }

  void onSendMessage(String content, int type) {
    // type: 0 = text, 1 = image, 2 = sticker
    isChatStart = false;
    if (content != null && content.trim() != '') {
      textEditingController.clear();

      chatBloc
          .sendMessage(groupChatId, id, receiverId, content,
              DateTime.now().millisecondsSinceEpoch.toString(), type, "message")
          .then((bool response) {
        if (response) {
          _sendDialogFlowMessage(content);
        }
      }).catchError((error) {});

      listScrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      FlutterToast.showToast('Nothing to send');
    }
  }

  void _sendFlowMessage(dynamic messageText, String featureType) {
    chatBloc
        .sendMessage(groupChatId, receiverId, id, messageText,
            DateTime.now().millisecondsSinceEpoch.toString(), 0, featureType)
        .then((bool response) {
      new Future.delayed(const Duration(milliseconds: 500)).then((data) {
        if (!isChatStart) {
          isDialogFlowResponsing = false;
          setState(() {});
        }
      });
    }).catchError((error) {});
    listScrollController.animateTo(0.0,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  Future<bool> onBackPress() {
    // if (isShowParty) {
    //   setState(() {
    //     isShowParty = false;
    //   });
    // } else {
    Navigator.pop(buildContext);
    // }
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {

    buildContext = context;

    // isDialogFlowResponsing = false;
    dialogFlowProvider = new DialogFlowProvider();
    searchContextProvider = new SearchContextProvider();

    chatBloc = ChatProvider.of(context);

    if(groupChatId == null || groupChatId.isEmpty){
      getChatId(receiverId);
      return Center(
          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(CustomColors.blueColor)));
    }else {
      return WillPopScope(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                // List of messages
                buildListMessage(),
                (isDialogFlowResponsing ? _addTypingSymbol() : Container()),
                // Input content
                buildInput(),
              ],
            ),

            // Loading
            buildLoading()
          ],
        ),
        onWillPop: onBackPress,
      );
    }
  }

  Widget buildLoading() {
    return Positioned(
      child: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(CustomColors.greenColor)),
              ),
              color: Colors.white.withOpacity(0.8),
            )
          : Container(),
    );
  }

  Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          // Edit text
          Flexible(
            child: Container(
              padding: EdgeInsets.only(left: 10.0),
              child: TextField(
                style:
                    TextStyle(color: CustomColors.blackColor, fontSize: 15.0),
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Reply...',
                  hintStyle: TextStyle(color: CustomColors.grayColor),
                ),
                focusNode: focusNode,
              ),
            ),
          ),
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 1.0),
              child: new IconButton(
                icon: Text('#'),
                onPressed: _showCaseList,
                color: CustomColors.lightGrayColor,
              ),
            ),
            color: Colors.white,
          ),
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 1.0),
              child: new IconButton(
                icon: new Icon(Icons.attach_file),
                onPressed: getImage,
                color: CustomColors.lightGrayColor,
              ),
            ),
            color: Colors.white,
          ),
          // Button send message
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 8.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () => onSendMessage(textEditingController.text, 0),
                color: CustomColors.blueColor,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: new BoxDecoration(
          border: new Border(
              top: new BorderSide(
                  color: CustomColors.grayTextColorDark, width: 0.5)),
          color: Colors.white),
    );
  }

  _showCaseList() {
    final RenderBox button = context.findRenderObject();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    final RelativeRect position = new RelativeRect.fromRect(
      new Rect.fromPoints(
        button.localToGlobal(button.size.bottomCenter(Offset.zero),
            ancestor: overlay),
        button.localToGlobal(button.size.bottomCenter(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    showMenu<String>(
            context: context,
            items: [
              PopupMenuItem(
                child: Text('45D05-1202-MF-00061'),
                value: '45D05-1202-MF-00061',
              ),
              PopupMenuItem(
                child: Text('29D02-1711-PL-010435'),
                value: '29D02-1711-PL-010435',
              ),
              PopupMenuItem(
                child: Text('29C01-1803-MF000130'),
                value: '29C01-1803-MF000130',
              ),
              PopupMenuItem(
                child: Text('29D03-1804-CC-000141'),
                value: '29D03-1804-CC-000141',
              ),
            ],
            position: position)
        .then((value) {
      if (value != null) {
        textEditingController.text += value;
      }
    });
  }

  Widget buildListMessage() {
    return Flexible(
      child: groupChatId == ''
          ? Center(
              child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(CustomColors.greenColor)))
          : StreamBuilder<List<Message>>(
              stream: chatBloc.getChatMessage(groupChatId),
              builder: (context, AsyncSnapshot<List<Message>> messageList) {
                if (!messageList.hasData) {
                  return Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              CustomColors.blueColor)));
                } else {
                  listMessage = messageList.data;

                  if (listMessage.length == 0) {
                    isChatStart = true;
                    _sendDialogFlowMessage("Hi");
                  }

                  return ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemBuilder: (context, index) =>
                        getMessageViewModel(messageList.data[index], id,
                            valueChange: (actionMessage) {
                          onSendMessage(actionMessage, 0);
                        }).build(),
                    itemCount: messageList.data.length,
                    reverse: true,
                    controller: listScrollController,
                  );
                }
              },
            ),
    );
  }

  Widget _addTypingSymbol() {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
      child: new Row(
        children: <Widget>[
          new CircleAvatar(backgroundColor: CustomColors.grayColor),
          Container(
            child: Text(
              "...",
              style: TextStyle(
                  color: CustomColors.blueColor,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w500),
            ),
            padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
            width: 60.0,
            decoration: BoxDecoration(
                color: CustomColors.lightGrayColor,
                borderRadius: BorderRadius.circular(8.0)),
            margin: EdgeInsets.only(left: 10.0),
          )
        ],
      ),
    );
  }
}
