import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common/bloc/login_bloc.dart';
import 'package:common/model/context.dart';
import 'package:courtfilechat_flutter/api/login_service.dart';

import 'package:courtfilechat_flutter/bloc_provider/app_provider.dart';

import 'package:common/model/case_number.dart';
import 'package:courtfilechat_flutter/bloc_provider/chat_provider.dart';
import 'package:courtfilechat_flutter/bloc_provider/context_provider.dart';
import 'package:courtfilechat_flutter/bloc_provider/login_provider.dart';

import 'package:courtfilechat_flutter/screen/chat/chat_screen.dart';
import 'package:courtfilechat_flutter/screen/login/login.dart';
import 'package:courtfilechat_flutter/util/custom_colors.dart';
import 'package:courtfilechat_flutter/util/memory_management.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_toast_pk/flutter_toast_pk.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uuid/uuid.dart';

class ChatUserScreen extends StatefulWidget {
  ChatUserScreen({Key key}) : super(key: key);

  @override
  State createState() => new ChatUserScreenState();
}

class ChatUserScreenState extends State<ChatUserScreen> {
  ChatUserScreenState({Key key});

  String currentUserId;
  String userEmail;

  bool isLoggedIn = false;

  String currentUserEmail;

  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  FirebaseUser currentUser;

  ContextProvider contextProvider = new ContextProvider();

  @override
  void initState() {
    super.initState();

//    isSignedIn();
    _checkUserId();
  }

  void _checkUserId() async{

    /*String userId = MemoryManagement.getUserId();
    if(userId == null || userId.isEmpty){
      var uuid = new Uuid();
      userId = uuid.v1();
      print(userId);
      MemoryManagement.setUserId(userId);
    }*/

    userEmail = MemoryManagement.getEmail();

    //redirect to login screen is userEmail is not exist
    if(userEmail == null || userEmail.isEmpty) {
      FlutterToast.showToast("Unable to find your email, please login again.");
      _navigateToLogin();
    }

    isLoggedIn = true;
    setState(() {});

  }


  void isSignedIn() async {
    //await googleSignIn.isSignedIn();
    await _ensureLoggedIn();
  }

  /*
  * currenlty google sign in feature is disabled
  * */
  Future<Null> _ensureLoggedIn() async {
    GoogleSignInAccount signedInUser = googleSignIn.currentUser;
    if (signedInUser == null)
      signedInUser = await googleSignIn.signInSilently();
    if (signedInUser == null) {
      await googleSignIn.signIn();
      // analytics.logLogin();
    }

    currentUserEmail = googleSignIn.currentUser.email;
    print(currentUserEmail);

    GoogleSignInAuthentication credentials = await googleSignIn.currentUser
        .authentication;
    FirebaseUser firebaseUser = await firebaseAuth.signInWithGoogle(
        idToken: credentials.idToken, accessToken: credentials.accessToken);

    if (firebaseUser != null) {
      // Check is already sign up
      final QuerySnapshot result =
      await Firestore.instance.collection('chatusers').where(
          'id', isEqualTo: firebaseUser.uid).getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
        // Update data to server if new user
        Firestore.instance.collection('chatusers')
            .document(firebaseUser.uid)
            .setData(
            {
              'name': firebaseUser.displayName,
              'photoUrl': firebaseUser.photoUrl,
              'id': firebaseUser.uid
            });

        // Write data to local
        currentUser = firebaseUser;

        currentUserId = currentUser.uid;

        MemoryManagement.setUserId(currentUser.uid);
        MemoryManagement.setName(currentUser.displayName);
        MemoryManagement.setPhotoUrl(currentUser.photoUrl);
      } else {
        currentUserId = documents[0]['id'];
        MemoryManagement.setUserId(documents[0]['id']);
        MemoryManagement.setName(documents[0]['name']);
        MemoryManagement.setPhotoUrl(documents[0]['photoUrl']);
      }
    }

    isLoggedIn = true;
    setState(() {});
  }


  Widget buildItem(BuildContext context, Context contextObj) {

      return Container(
        child: FlatButton(
          child: Row(
            children: <Widget>[
              new Flexible(
                child: Container(
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        child: Text(
                          '${contextObj.name}',
                          style: TextStyle(color: CustomColors.blackColor),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: new EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 5.0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>  AppProvider(
                                          child: new Chat(
                        receiverName : contextObj.name,
                        receiverId: contextObj.contextDocId,
                      ),
                    )));
          },
          color: CustomColors.grayColor,
          padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
      );
  }

  @override
  Widget build(BuildContext context) {

    final chatBloc = ChatProvider.of(context);

    if(!isLoggedIn) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(CustomColors.blueColor)),
        ),
        color: Colors.white.withOpacity(0.8),
      );
    }

    return new Container(
        child: new Column(
          children: <Widget>[
            Expanded(
              child: StreamBuilder<List<Context>>(
                stream: contextProvider.contextBloc.getUserContext(userEmail),
                builder: (BuildContext context, AsyncSnapshot<List<Context>> contextList) {
                  if (!contextList.hasData){
                    return Center(
                        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(CustomColors.blueColor)));
                  };

                  final int messageCount = contextList.data.length;
                  return Padding(padding: EdgeInsets.only(top: 5.0),
                      child: ListView.builder(
                    itemCount: messageCount,
                    itemBuilder: (context, index) => buildItem(context, contextList.data[index]),
                  ));
                },
              ),
              flex: 1,
            ),
            new Divider(height: 1.0),
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

  //redirect to login screen and clear memory
  void _navigateToLogin() async{
    MemoryManagement.clearMemory();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (context) =>
              LoginProvider(
                  child: new LoginPage(),
                  loginBloc: LoginBloc(LoginServiceApi()))
      ), (Route<dynamic> route) => false);
    });
  }

}