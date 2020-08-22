import 'dart:async';

import 'package:common/base/base_api.dart';
import 'package:common/model/case_number.dart';
import 'package:common/model/message.dart';

abstract class ChatApi{ 

  Stream<List<Message>> getChatMessage(String chatId);

  Stream<List<CaseNumber>> getCaseNumberList();

  Future<bool> sendMessage(String chatId, String senderId, String receiverId, dynamic content, String timestamp,int type, String featureType);

  Future<String> getContextChatId(String contextId);
}