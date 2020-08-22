import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common/api/filing_api.dart';
import 'package:common/model/filing.dart';

class FilingServiceApi extends FilingApi {
  static String FILINGS_COLLECTION = "filings";

  @override
  Stream<List<Filing>> getFilingList(String sessionId) {
    StreamController<List<Filing>> controller = new StreamController<List<Filing>>();

    Stream<QuerySnapshot> snapshots = Firestore.instance.collection(FILINGS_COLLECTION).snapshots();
    snapshots.listen((QuerySnapshot snapshot) {
      final List<Filing> countyList = snapshot.documents
          .map((documentSnapshot) => Filing.fromMap(documentSnapshot.data))
          .toList();

      controller.add(countyList);
    });

    return controller.stream;
  }
}