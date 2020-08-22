import 'dart:async';

import 'package:common/api/context_api.dart';
import 'package:common/bloc/bloc.dart';
import 'package:common/model/context.dart';

class ContextBloc extends Bloc{

  ContextApi contextApi;

  ContextBloc(this.contextApi){
  }

  Stream<List<Context>> getUserContext(String userEmail) {
    return contextApi.getUserContext(userEmail);
  }

  Future<bool> updateContextFiling(String contextId, dynamic filing) =>
      contextApi.updateContextFiling(contextId, filing);

  @override
  void dispose() {
    // TODO: implement dispose
  }

}