import 'package:common/bloc/login_bloc.dart';
import 'package:courtfilechat_flutter/api/login_service.dart';
import 'package:flutter/widgets.dart';

class LoginProvider extends InheritedWidget {
  final LoginBloc loginBloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  LoginProvider({Key key, Widget child, LoginBloc loginBloc})
      : loginBloc = loginBloc ?? LoginBloc(LoginServiceApi()), super(key: key, child: child);


  static dynamic of(BuildContext context, String blocName){
    if(blocName=='loginBloc'){
      return (context.inheritFromWidgetOfExactType(LoginProvider) as LoginProvider).loginBloc;
    }
  }

}