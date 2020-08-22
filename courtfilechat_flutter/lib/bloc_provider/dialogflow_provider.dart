import 'package:courtfilechat_flutter/api/dialogflow_service_api.dart';
import 'package:flutter/widgets.dart';

import 'package:common/bloc/dialogflow_bloc.dart';

class DialogFlowProvider extends InheritedWidget {

  DialogFlowBloc dialogFlowBloc;

  DialogFlowProvider() {
    this.dialogFlowBloc = DialogFlowBloc(DialogFlowServiceApi());
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static DialogFlowProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(DialogFlowProvider);
  }

}