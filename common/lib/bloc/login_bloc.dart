import 'dart:async';
import 'package:common/api/login_api.dart';

import '../bloc/bloc.dart';

class LoginBloc extends Bloc {
  final LoginApi loginApi;
  LoginBloc(this.loginApi);

  Future convertPlaintextToCipherText(String plaintext) => loginApi.convertPlaintextToCipherText(plaintext);

  Future authenticateWithEncryptedPassword(String login, String password, String portalGroup) =>
      loginApi.authenticateWithEncryptedPassword(login, password, portalGroup);

  @override
  void dispose() {

  }
}
