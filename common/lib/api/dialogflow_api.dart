import 'dart:async';

import 'package:common/base/base_api.dart';

abstract class DialogFlowApi extends BaseApi{

  Future<Map<dynamic, dynamic>> sendQuery(String sessionId, String content);
}