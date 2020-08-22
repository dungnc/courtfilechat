import 'package:common/api_service/code_label_service_api.dart';
import 'package:common/bloc/code_label_bloc.dart';
import 'package:common/bloc/court_bloc.dart';
import 'package:courtfilechat_flutter/api/court_service_api.dart';
import 'package:flutter/widgets.dart';

class CourtProvider extends InheritedWidget {
  final CodeLabelBloc codeLabelBloc;
  final CourtBloc courtBloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;


  CourtProvider({Key key, Widget child, CourtBloc courtBloc, CodeLabelBloc codeLabelBloc,})
      : codeLabelBloc = codeLabelBloc ?? CodeLabelBloc(CodeLabelServiceApi()),
        courtBloc = courtBloc ?? CourtBloc(CourtServiceApi()), super(key: key, child: child);


  static dynamic of(BuildContext context, String blocName){
    if(blocName=='codeLabelBloc'){
      return (context.inheritFromWidgetOfExactType(CourtProvider) as CourtProvider).codeLabelBloc;
    }
    if(blocName=='courtBloc'){
      return (context.inheritFromWidgetOfExactType(CourtProvider) as CourtProvider).courtBloc;
    }
  }

}