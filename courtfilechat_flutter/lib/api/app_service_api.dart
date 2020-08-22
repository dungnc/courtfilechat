import 'dart:async';

import 'package:common/api/app_api.dart';


const kEndPointUrl = 'http://beta.lakecountyin.org:8888/efilinglocal/';
const kApiEndPointUrl = '_api';

class AppServiceApi extends AppApi {
  AppServiceApi({String endPoint: kEndPointUrl}) {
    setBaseApiUrl(endPoint);
  }

  @override
  Future searchCaseService(
      {String userName: '',
      String trackingID: '',
      String courtOrganizationId: ''}) {
    return this.getMethod(
        '$kApiEndPointUrl/courtRecord/getCaseDetails?userName=""&trackingID=$trackingID&courtOrganizationId=$courtOrganizationId');
  }
}
