import 'package:common/model/message.dart';
import 'package:courtfilechat_flutter/screen/chat/models/dialogflow_message.dart';
import 'package:courtfilechat_flutter/screen/chat/models/info_message.dart';
import 'package:courtfilechat_flutter/screen/chat/models/party_message.dart';
import 'package:flutter/widgets.dart';

import './message.dart';
import './customer_message.dart';

MessageViewModel getMessageViewModel(Message message, String id,
    {ValueChanged<String> valueChange}) {
  switch (message.featureType) {
    case 'message':
      if (message.idFrom != id) {
        return DialogFlowMessage(message: message);
      } else {
        return CustomerMessage(message: message);
      }
      break;
    case 'info':
      return InfoMessage(message: message, eventValueChange: valueChange);
    case 'party':
      return PartyMessage(message: message);
      break;
    default:
      return MessageViewModel(message: message);
  }
}
