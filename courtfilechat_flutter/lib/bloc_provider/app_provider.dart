import 'package:courtfilechat_flutter/api/app_service_api.dart';
import 'package:flutter/material.dart';

import 'package:common/bloc/app_bloc.dart';

class AppProvider extends InheritedWidget {
  final AppBloC appBloC;

  AppProvider({AppBloC appBloC, Key key, Widget child})
      : this.appBloC = appBloC ?? AppBloC(AppServiceApi()),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static AppProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AppProvider);
  }
}
