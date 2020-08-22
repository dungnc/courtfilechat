import 'package:common/bloc/filing_bloc.dart';
import 'package:courtfilechat_flutter/api/chat_service_api.dart';
import 'package:courtfilechat_flutter/api/filing_service_api.dart';
import 'package:flutter/widgets.dart';
import 'package:common/bloc/chat_bloc.dart';

class FilingProvider extends InheritedWidget {

  final FilingBloc filingBloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;


  FilingProvider({Key key, FilingBloc filingBloc, Widget child})
      : filingBloc = filingBloc ?? FilingBloc(FilingServiceApi()), super(key: key, child: child);


  static FilingBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(FilingProvider) as FilingProvider)
          .filingBloc;
}