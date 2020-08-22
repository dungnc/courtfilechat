import 'dart:async';

import 'package:common/api/dialogflow_api.dart';
import 'package:common/bloc/bloc.dart';

class DialogFlowBloc extends Bloc{

  DialogFlowApi dialogFlowApi;

  DialogFlowBloc(this.dialogFlowApi){
  }

  Future<Map<dynamic, dynamic>> sendQuery(String sessionId, String content) =>
      dialogFlowApi.sendQuery(sessionId, content);

  @override
  void dispose() {
    // TODO: implement dispose
  }
}