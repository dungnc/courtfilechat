import 'dart:async';

import 'package:common/model/search_context.dart';

abstract class SearchContextApi{

  Future<bool> setSearchContext(String contextId, SearchContext searchContext);

  Future<SearchContext> getSearchContext(String contextId);
}