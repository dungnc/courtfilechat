import 'package:flutter/material.dart';

class MessageInput extends StatefulWidget {
  final ValueChanged<String> onSend;

  const MessageInput({Key key, this.onSend}) : super(key: key);

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  bool _isComposingMessage = false;
  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   color: Colors.blueGrey,
    //   height: 50.0,
    //   child:
    //   // Row(
    //     // children:[
    //       TextField(),
    //     // ],
    //   // ),
    // );
    return _buildTextComposer();
  }

  Widget _buildTextComposer() {
    return new Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(width: 1.0, color: Colors.grey)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: new Row(
        children: <Widget>[
          Flexible(
            child: Container(
              padding: const EdgeInsets.fromLTRB(10.0, 3.0, 10.0, 8.0),
              child: TextField(
                controller: _textEditingController,
                onChanged: (String messageText) {
                  setState(() {
                    _isComposingMessage = messageText.length > 0;
                  });
                },
                // onSubmitted: _textMessageSubmitted,
                decoration: InputDecoration.collapsed(hintText: "Reply..."),
              ),
            ),
          ),
           Container(
            margin:  EdgeInsets.symmetric(horizontal: 4.0),
            child:  IconButton(
                icon:  Icon(
                  Icons.attach_file,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () {}
                // () async {
                //   await _ensureLoggedIn();
                //   File imageFile = await ImagePicker.pickImage();
                //   int timestamp = new DateTime.now().millisecondsSinceEpoch;
                //   StorageReference storageReference = FirebaseStorage
                //       .instance
                //       .ref()
                //       .child("img_" + timestamp.toString() + ".jpg");
                //   StorageUploadTask uploadTask =
                //       storageReference.put(imageFile);
                //   Uri downloadUrl = (await uploadTask.future).downloadUrl;
                //   _sendMessage(
                //       messageText: null, imageUrl: downloadUrl.toString());
                // }
                ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(icon: Icon(Icons.send), onPressed: () {
              if (_textEditingController.text.length > 0){
                widget.onSend(_textEditingController.text);
                _textEditingController.text = "";
              }
            },),
          ),
        ],
      ),
    );
  }
}
