import 'dart:async';

import 'package:common/api/court_api.dart';
import 'package:common/bloc/bloc.dart';
import 'package:common/model/county.dart';

class CourtBloc extends Bloc{

  CourtApi courtApi;

  CourtBloc(this.courtApi){

  }

  Future<List<County>> getCountyList() => courtApi.getCountyList();

  @override
  void dispose() {
    // TODO: implement dispose
  }

}