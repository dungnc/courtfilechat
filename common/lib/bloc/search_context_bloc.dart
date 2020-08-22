import 'dart:async';

import 'package:common/api/search_context_api.dart';
import 'package:common/bloc/bloc.dart';
import 'package:common/model/search_context.dart';

class SearchContextBloc extends Bloc{
  SearchContextApi searchContextApi;

  SearchContextBloc(this.searchContextApi){
  }

  Future<bool> setSearchContext(String contextId, SearchContext searchContext) =>
      searchContextApi.setSearchContext(contextId, searchContext);

  Future<SearchContext> getSearchContext(String contextId) =>
      searchContextApi.getSearchContext(contextId);

  @override
  void dispose() {
    // TODO: implement dispose
  }

}