import 'dart:async';

import '../bloc/bloc.dart';
import '../api/app_api.dart';

class AppBloC extends Bloc {
  final AppApi appApi;
  AppBloC(this.appApi);

  Future searchCaseService(
          {String userName, String trackingID, String courtOrganizationId}) =>
      appApi.searchCaseService(
          userName: userName,
          trackingID: trackingID,
          courtOrganizationId: courtOrganizationId);

  @override
  void dispose() {
   
  }
}
