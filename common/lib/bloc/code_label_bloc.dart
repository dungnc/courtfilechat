import 'dart:async';

import 'package:common/api/code_label_api.dart';
import 'package:common/bloc/bloc.dart';
import 'package:common/model/localtion_code_list.dart';

class CodeLabelBloc extends Bloc {

  CodeLabelApi _CodeLabelApi;
  CodeLabelBloc(this._CodeLabelApi){

  }

  Future<LocationCodeList> getStateCodeList() => _CodeLabelApi.populateCompleteLocationCodeList();

  @override
  void dispose() {

  }
}