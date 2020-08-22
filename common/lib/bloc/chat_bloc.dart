import 'dart:async';

import 'package:common/api/chat_api.dart';
import 'package:common/bloc/bloc.dart';
import 'package:common/model/case_number.dart';
import 'package:common/model/message.dart';

class ChatBloc extends Bloc{ 

  ChatApi chatApi;

  ChatBloc(this.chatApi){
  }

  Future<bool> sendMessage(String chatId, String senderId, String receiverId, dynamic content, String timestamp,int type, String featureType) =>
      chatApi.sendMessage(chatId, senderId, receiverId, content, timestamp, type, featureType);

  Stream<List<CaseNumber>> getCaseNumberList() {
    return chatApi.getCaseNumberList();
  }

  Stream<List<Message>> getChatMessage(String chatId) {
    return chatApi.getChatMessage(chatId);
  }

  Future<String> getContextChatId(String contextId) =>
      chatApi.getContextChatId(contextId);

  @override
  void dispose() {
    // TODO: implement dispose
  }

}