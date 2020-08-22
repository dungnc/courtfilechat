import 'dart:async';

import 'package:common/base/base_api.dart';
import 'package:common/model/filing.dart';

abstract class FilingApi extends BaseApi{

  Stream<List<Filing>> getFilingList(String sessionId);
}