import 'dart:async';

import 'package:flutter_toast_pk/flutter_toast_pk.dart';
import 'package:common/api/login_api.dart';
import 'package:common/base/base_api_constant.dart';

class LoginServiceApi extends LoginApi {

  static String BASE_URL = 'https://efsplocal-in-staging.appspot.com/_api/';

  LoginServiceApi(){
    super.setBaseApiUrl(BASE_URL);
  }

  @override
  Future authenticateWithEncryptedPassword(String login, String password, String portalGroup) async {
    var response = await getMethod(API_REFERENCE['user']['authenticateWithEncryptedPassword'],
        body: { "login" : login, "password" : password, "portalGroup" : portalGroup });

    if(response!=null && response is Map && response.containsKey("cause")){
      FlutterToast.showToast(response['cause']);
      return null;
    }
    return response;
  }

  @override
  Future convertPlaintextToCipherText(String plaintext) async {
    var response = await getMethod(API_REFERENCE['user']['convertPlaintextToCipherText'],
                    body: { "plaintext" : plaintext });
    print("response");
    print(response);
    return response;
  }

}