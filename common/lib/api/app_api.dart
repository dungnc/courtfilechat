import 'dart:async';

import '../base/base_api.dart';


abstract class AppApi extends BaseApi{
  Future searchCaseService({String userName, String trackingID, String courtOrganizationId});
}