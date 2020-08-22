import 'dart:async';

import 'package:common/base/base_api.dart';
import 'package:common/model/localtion_code_list.dart';

abstract class CodeLabelApi extends BaseApi{
  Future<LocationCodeList> populateCompleteLocationCodeList();
}