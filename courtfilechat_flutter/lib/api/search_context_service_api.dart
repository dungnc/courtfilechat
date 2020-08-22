import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common/api/search_context_api.dart';
import 'package:common/model/search_context.dart';

class SearchContextServiceApi extends SearchContextApi {

  static String SEARCH_CONTEXT_COLLECTION = "context/search";

  @override
  Future<SearchContext> getSearchContext(String contextId) {
    // TODO: implement getSearchContext
  }

  @override
  Future<bool> setSearchContext(String contextId, SearchContext searchContext) async{
    DocumentReference searchContextDocRef = Firestore.instance
        .document(SEARCH_CONTEXT_COLLECTION)
        .collection(contextId)
        .document("data");

    bool response = false;
    await Firestore.instance.runTransaction((Transaction transaction) async {
      await transaction.set(
        searchContextDocRef,
        SearchContext.toMap(searchContext),
      );
    }).whenComplete((){
      response = true;
    }).catchError((error){
      response = false;
    });

    return response;
  }

}