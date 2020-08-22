import 'package:common/bloc/search_context_bloc.dart';
import 'package:courtfilechat_flutter/api/search_context_service_api.dart';
import 'package:flutter/material.dart';

class SearchContextProvider extends InheritedWidget {

  SearchContextBloc searchContextBloc;

  SearchContextProvider() {
    this.searchContextBloc = SearchContextBloc(SearchContextServiceApi());
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static SearchContextProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(SearchContextProvider);
  }

}