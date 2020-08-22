import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common/api/context_api.dart';
import 'package:common/model/context.dart';
import 'package:common/util/format_util.dart';

class ContextServiceApi extends ContextApi {

  static String CONTEXT_COLLECTION = "context";

  @override
  Stream<List<Context>> getUserContext(String userEmail) {

    StreamController<List<Context>> controller = new StreamController<List<Context>>();

    userEmail = Utils.singleton.formatEmailToString(userEmail);

    print(userEmail);
    CollectionReference contextRef = Firestore.instance.collection(CONTEXT_COLLECTION);
    contextRef.where(userEmail,isEqualTo: true).snapshots().listen((QuerySnapshot querySnapshot){

      List<Context> contextList = new List<Context>();

      for(DocumentSnapshot doc in querySnapshot.documents) {
        String contextDocId = doc.documentID;

        Context context = Context.fromMap(doc.data);
        context.contextDocId = contextDocId;

        contextList.add(context);
      }
      controller.add(contextList);
    });

    return controller.stream;
  }

  @override
  Future<bool> updateContextFiling(String contextId, filing) {
    CollectionReference filingCollectionRef = Firestore.instance.
                        collection(CONTEXT_COLLECTION)
                        .document(contextId)
                        .collection("filing");

    filingCollectionRef.getDocuments().then((QuerySnapshot querySnapshot){
      print(querySnapshot.documents.length);
      if(querySnapshot.documents.length > 0){
        DocumentReference filingDocRef = querySnapshot.documents[0].reference;
        filingDocRef.setData(filing);
      }else{
        filingCollectionRef.add(filing);
      }
    });
  }

}