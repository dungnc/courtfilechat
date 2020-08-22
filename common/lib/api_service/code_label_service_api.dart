import 'dart:async';

import 'package:common/api/code_label_api.dart';
import 'package:common/base/base_api_constant.dart';
import 'package:common/model/localtion_code_list.dart';

const kEndPointUrl = 'https://efsplocal-in-staging.appspot.com//_api/';

class CodeLabelServiceApi extends CodeLabelApi{
  CodeLabelServiceApi({String endPoint: kEndPointUrl}) {
    setBaseApiUrl(endPoint);
  }

  /*
  * Get location list
  */
  @override
  Future<LocationCodeList> populateCompleteLocationCodeList() async {

    LocationCodeList locationCodeList = new LocationCodeList();
    var response = await getMethod(API_REFERENCE['codeLabel']['populateCompleteLocationCodeList']);
    print("response");
    print(response);
    locationCodeList = locationCodeList.fromJson(response);
    return locationCodeList;
  }

}