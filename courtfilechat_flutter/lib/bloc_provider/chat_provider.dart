import 'package:courtfilechat_flutter/api/chat_service_api.dart';
import 'package:flutter/widgets.dart';
import 'package:common/bloc/chat_bloc.dart';

class ChatProvider extends InheritedWidget {

  final ChatBloc chatBloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;


  ChatProvider({Key key, ChatBloc chatBloc, Widget child})
      : chatBloc = chatBloc ?? ChatBloc(ChatServiceApi()), super(key: key, child: child);


  static ChatBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(ChatProvider) as ChatProvider)
          .chatBloc;
}