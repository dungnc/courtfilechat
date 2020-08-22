import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common/api/chat_api.dart';
import 'package:common/model/case_number.dart';
import 'package:common/model/message.dart';
import 'package:courtfilechat_flutter/screen/chat/models/proxy_message.dart';
class ChatServiceApi extends ChatApi {

  static String MESSAGES_COLLECTION = "messages";
  static String CASENUMBER_COLLECTION = "casenumbers";

  @override
  Stream<List<Message>> getChatMessage(String chatId) {
    StreamController<List<Message>> controller =
    new StreamController<List<Message>>();

    Stream<QuerySnapshot> snapshots = Firestore.instance
        .collection(MESSAGES_COLLECTION)
        .document(chatId)
        .collection("messages")//.collection(chatId)
        .orderBy('timestamp', descending: true)
        .limit(20)
        .snapshots();

    snapshots.listen((QuerySnapshot snapshot) {
      final List<Message> messageList = snapshot.documents
          .map((documentSnapshot) => Message.fromMap(documentSnapshot.data))
          .toList();

      controller.add(messageList);
    });

    return controller.stream;
  }

  @override
  Stream<List<CaseNumber>> getCaseNumberList() {
    StreamController<List<CaseNumber>> controller = new StreamController<List<CaseNumber>>();

    Stream<QuerySnapshot> snapshots = Firestore.instance.collection(CASENUMBER_COLLECTION).snapshots();

    snapshots.listen((QuerySnapshot snapshot) {
      final List<CaseNumber> caseNumberList = snapshot.documents
          .map((documentSnapshot) => CaseNumber.fromMap(documentSnapshot.data))
          .toList();

      controller.add(caseNumberList);
    });

    return controller.stream;
  }

  @override
  Future<bool> sendMessage(String chatId, String senderId, String receiverId, dynamic content, String timestamp, int type, String featureType) async{
    CollectionReference messageCollectionRef = Firestore.instance
        .collection('messages')
        .document(chatId)
        .collection("messages");//.collection(chatId);

    bool response = false;
    DocumentReference documentReference = messageCollectionRef.document(timestamp);
    await Firestore.instance.runTransaction((Transaction transaction) async {
      await transaction.set(
        documentReference,
        {
          'idFrom': senderId,
          'idTo': receiverId,
          'timestamp': timestamp,
          'content': content,
          'type': type,
          'featureType' : featureType
        },
      );
    }).whenComplete((){
      response = true;
    }).catchError((error){
      response = false;
    });

    return response;
  }

  @override
  Future<String> getContextChatId(String contextId) {
    Completer<String> completer = new Completer<String>();

    CollectionReference messageRef = Firestore.instance.collection(MESSAGES_COLLECTION);

    StreamSubscription subscription;

    subscription = messageRef.where(contextId,isEqualTo: true).snapshots().listen((QuerySnapshot querySnapshot){
      subscription.cancel();
      if(querySnapshot.documents.length > 0){
        String chatId = querySnapshot.documents[0].documentID;
        print(chatId);
        completer.complete(chatId);
      }else{
        messageRef.add({
          contextId : true
        }).then((DocumentReference docRef){
          print(docRef.documentID);
          completer.complete(docRef.documentID);
        });
      }
    });

    return completer.future;
  }

}