import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common/api/court_api.dart';
import 'package:common/model/county.dart';

class CourtServiceApi extends CourtApi {
  static String COURTS_COLLECTION = "courts";

  @override
  Future<List<County>> getCountyList() async {
    StreamController<List<County>> controller = new StreamController<List<County>>();

    Stream<QuerySnapshot> snapshots = Firestore.instance.collection(COURTS_COLLECTION).snapshots();
    snapshots.listen((QuerySnapshot snapshot) {
      final List<County> countyList = snapshot.documents
          .map((documentSnapshot) => County.fromMap(documentSnapshot.data))
          .toList();

      controller.add(countyList);
    });

    return controller.stream.first;
  }
}