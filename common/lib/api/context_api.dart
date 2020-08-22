import 'dart:async';

import 'package:common/model/context.dart';

abstract class ContextApi{

  Stream<List<Context>> getUserContext(String userEmail);

  Future<bool> updateContextFiling(String contextId, dynamic filing);
}