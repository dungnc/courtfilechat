import 'dart:async';

import '../base/base_api.dart';

abstract class LoginApi extends BaseApi{
  Future convertPlaintextToCipherText(String plaintext);

  Future authenticateWithEncryptedPassword(String login, String password, String portalGroup);
}