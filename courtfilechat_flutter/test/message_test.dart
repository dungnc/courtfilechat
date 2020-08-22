//import 'dart:async';

import 'package:common/bloc/chat_bloc.dart';
import 'package:common/model/case_number.dart';
import 'package:common/model/message.dart';
import 'package:courtfilechat_flutter/api/chat_service_api.dart';
//import 'package:test/test.dart';
import 'package:uuid/uuid.dart';
/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';*/

import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  ChatBloc _chatBloc;

  const String _senderId = "5001";
  const String _receiverId = "6000";
  const String _groupChatId = "5001-6000";
  const String _message = "Hi";
  const String _timestamp = "1539622948074";

  FirebaseApp app;
  Firestore firestore;
  final List<MethodCall> log = <MethodCall>[];
  const Map<String, dynamic> kMockDocumentSnapshotData = <String, dynamic>{
    '1': 2
  };

  const Map<String, dynamic> chatMockDocumentSnapshotData = <String, dynamic>{
    'content' : _message,
    'idFrom' : _senderId,
    'idTo' : _receiverId,
    'timestamp' : _timestamp,
    'type' : 0,
    'featureType' : ""
  };

  CollectionReference collectionReference;

  int mockHandleId = 0;

  setUpAll(() async{
    _chatBloc = ChatBloc(ChatServiceApi());

    mockHandleId = 0;
    FirebaseApp.channel.setMockMethodCallHandler(
        (MethodCall methodCall) async {},
        );
    app = await FirebaseApp.configure(
        name: 'courtfilechat',
        options: const FirebaseOptions(
            googleAppID: '1:494665413213:android:00fb4522b47513e3',
            gcmSenderID: '494665413213',
            ),
        );
    firestore = Firestore(app: app);
    collectionReference = firestore.collection('messages');

    Firestore.channel.setMockMethodCallHandler((MethodCall methodCall) async {
      log.add(methodCall);
      switch (methodCall.method) {
        case 'Firestore#runTransaction':
          return <String, dynamic>{
            'content' : _message,
            'idFrom' : _senderId,
            'idTo' : _receiverId,
            'timestamp' : _timestamp,
            'type' : 0,
            'featureType' : ""
          };
        case 'Transaction#set':
          return null;
        case 'Query#addSnapshotListener':
          final int handle = mockHandleId++;
          // Wait before sending a message back.
          // Otherwise the first request didn't have the time to finish.
          Future.delayed(Duration.zero).then((_) {
              BinaryMessages.handlePlatformMessage(
                  Firestore.channel.name,
                  Firestore.channel.codec.encodeMethodCall(
                      MethodCall('QuerySnapshot', <String, dynamic>{
                        'app': app.name,
                        'handle': handle,
                        'paths': <String>["${methodCall.arguments['path']}/${_groupChatId}/${_groupChatId}"],
                        'documents': <dynamic>[chatMockDocumentSnapshotData],
                        'documentChanges': <dynamic>[
                          <String, dynamic>{
                            'oldIndex': -1,
                            'newIndex': 1,
                            'type': 'DocumentChangeType.added',
                            'document': chatMockDocumentSnapshotData,
                          },
                        ],
                      }),
                      ),
                  (_) {},
                  );
              });
            return handle;
        default:
          return null;
}
    });
  });

  group('Message', () {

    test('Get', () async {
      Stream<List<Message>> messageList = _chatBloc.getChatMessage(_groupChatId);

      messageList.listen((List<Message> messages) {
        expect(messages.length, isNot(0));

        messages.forEach((Message message) {
          print(Message.toMap(message));

          expect(_message, message.content);
          expect(_senderId, message.idFrom);
          expect(_receiverId, message.idTo);
        });
      });
    });

    test('send', () async {
      bool response = await _chatBloc.sendMessage(
          _senderId,
          _receiverId,
          _groupChatId,
          _message,
          _timestamp,
          0,
          "");

      print(response);
      expect(response, true);
    });
  });

}