import 'dart:async';

import 'package:common/model/county.dart';

abstract class CourtApi{
  Future<List<County>> getCountyList();
}