import 'dart:async';

import 'package:common/api/filing_api.dart';
import 'package:common/bloc/bloc.dart';
import 'package:common/model/filing.dart';

class FilingBloc extends Bloc{

  FilingApi filingsApi;

  FilingBloc(this.filingsApi){
  }

  Stream<List<Filing>> getFilingList(String sessionId) =>
      filingsApi.getFilingList(sessionId);

  @override
  void dispose() {
    // TODO: implement dispose
  }
}