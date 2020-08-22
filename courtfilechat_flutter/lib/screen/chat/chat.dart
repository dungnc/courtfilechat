import 'dart:async';
import 'dart:io';

import 'package:courtfilechat_flutter/screen/chat/dialogflow/dialogflow_api.dart';
import 'package:courtfilechat_flutter/screen/chat/widgets/chat_message_item.dart' as item;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:courtfilechat_flutter/screen/chat/widgets/message_input_widget.dart';
import 'package:courtfilechat_flutter/screen/chat/models/message.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firestore_ui/animated_firestore_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:image_picker/image_picker.dart';

final googleSignIn = new GoogleSignIn();
// final analytics = new FirebaseAnalytics();

final auth = FirebaseAuth.instance;
var currentUserEmail;
final flowApi = DialogFlowApi();

class ChatPage extends StatefulWidget {
  // ChatPage() {}

  @override
  State<StatefulWidget> createState() {
    return new ChatPageState();
  }
}

class ChatPageState extends State<ChatPage> {
  bool _isComposingMessage = false;
  TextEditingController _textEditingController = TextEditingController();
  // var reference = FirebaseDatabase.instance.reference().child('messages');
  var fileStore = Firestore.instance.collection("views/chat/test");

  @override
  void initState() {
    super.initState();
    // _init();

    // FirebaseAuth.instance.ini
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Widget>[
          Expanded(
            child: FirestoreAnimatedList(
              query: fileStore.snapshots(),
              padding: const EdgeInsets.all(8.0),
              // sort: (a, b) => b.key.compareTo(a.key),
              //comparing timestamp of messages to check which one would appear first
              itemBuilder: (_, snapShot, animation, index) {
                return new item.ChatMessageListItem(
                  messageSnapshot: snapShot,
                  animation: animation,
                );
                // return Text("${snapShot.data.toString()}");
              },
            ),
            flex: 1,
          ),
          new Divider(height: 1.0),
          new Container(
            decoration: new BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
      decoration: Theme.of(context).platform == TargetPlatform.iOS
          ? new BoxDecoration(
              border: new Border(
                  top: new BorderSide(
              color: Colors.grey[200],
            )))
          : null,
    );
  }

  CupertinoButton getIOSSendButton() {
    return new CupertinoButton(
      child: new Text("Send"),
      onPressed: _isComposingMessage
          ? () => _textMessageSubmitted(_textEditingController.text)
          : null,
    );
  }

  IconButton getDefaultSendButton() {
    return new IconButton(
      icon: new Icon(Icons.send),
      onPressed: _isComposingMessage
          ? () => _textMessageSubmitted(_textEditingController.text)
          : null,
    );
  }

  Widget _buildTextComposer() {
    return new IconTheme(
        data: new IconThemeData(
          color: _isComposingMessage
              ? Theme.of(context).accentColor
              : Theme.of(context).disabledColor,
        ),
        child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(
            children: <Widget>[
              new Flexible(
                child: new TextField(
                  controller: _textEditingController,
                  onChanged: (String messageText) {
                    setState(() {
                      _isComposingMessage = messageText.length > 0;
                    });
                  },
                  onSubmitted: _textMessageSubmitted,
                  decoration:
                      new InputDecoration.collapsed(hintText: "Send a message"),
                ),
              ),
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: new IconButton(
                    icon: new Icon(
                      Icons.attach_file,
                      color: Theme.of(context).accentColor,
                    ),
                    onPressed: () async {
                      // _signOut();
                      // await _ensureLoggedIn();
                      // File imageFile = await ImagePicker.pickImage();
                      // int timestamp = new DateTime.now().millisecondsSinceEpoch;
                      // StorageReference storageReference = FirebaseStorage
                      //     .instance
                      //     .ref()
                      //     .child("img_" + timestamp.toString() + ".jpg");
                      // StorageUploadTask uploadTask =
                      //     storageReference.put(imageFile);
                      // Uri downloadUrl = (await uploadTask.future).downloadUrl;
                      // _sendMessage(
                      //     messageText: null, imageUrl: downloadUrl.toString());
                    }),
              ),
              new Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Theme.of(context).platform == TargetPlatform.iOS
                    ? getIOSSendButton()
                    : getDefaultSendButton(),
              ),
            ],
          ),
        ));
  }

  Future<Null> _textMessageSubmitted(String text) async {
    _textEditingController.clear();

    setState(() {
      _isComposingMessage = false;
    });

    await _ensureLoggedIn();
    flowApi.query(content: text, sessionId: currentUserEmail).then((data) {
      // print("data ${data['result']['speech']}");
      _sendFlowMessage(messageText: data['result']['speech'], imageUrl: null);
    });
    _sendMessage(messageText: text, imageUrl: null);
  }

  void _sendFlowMessage({String messageText : '', String imageUrl}) {
    fileStore.document().setData({
      'text': messageText,
      'email': 'DialogFlow',
      'imageUrl': imageUrl,
      'senderName': 'DialogFlow',
      'senderPhotoUrl': '',
    });
  }

  void _sendMessage({String messageText, String imageUrl}) {
    fileStore.document().setData({
      'text': messageText,
      'email': googleSignIn.currentUser.email,
      'imageUrl': imageUrl,
      'senderName': googleSignIn.currentUser.displayName,
      'senderPhotoUrl': googleSignIn.currentUser.photoUrl,
    });

    // analytics.logEvent(name: 'send_message');
  }

  Future<Null> _ensureLoggedIn() async {
    GoogleSignInAccount signedInUser = googleSignIn.currentUser;
    if (signedInUser == null)
      signedInUser = await googleSignIn.signInSilently();
    if (signedInUser == null) {
      await googleSignIn.signIn();
      // analytics.logLogin();
    }

    currentUserEmail = googleSignIn.currentUser.email;
    item.currentUserEmail = currentUserEmail;
    if (await auth.currentUser() == null) {
      GoogleSignInAuthentication credentials =
          await googleSignIn.currentUser.authentication;
      await auth.signInWithGoogle(
          idToken: credentials.idToken, accessToken: credentials.accessToken);
    }
  }

  Future _signOut() async {
    await auth.signOut();
    googleSignIn.signOut();
    Scaffold.of(context)
        .showSnackBar(new SnackBar(content: new Text('User logged out')));
  }
}
