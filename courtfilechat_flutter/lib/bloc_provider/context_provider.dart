import 'package:common/bloc/context_bloc.dart';
import 'package:courtfilechat_flutter/api/context_service_api.dart';
import 'package:flutter/material.dart';

class ContextProvider extends InheritedWidget {

  ContextBloc contextBloc;

  ContextProvider() {
    this.contextBloc = ContextBloc(ContextServiceApi());
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static ContextProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(ContextProvider);
  }

}