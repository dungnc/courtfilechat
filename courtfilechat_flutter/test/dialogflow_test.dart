import 'dart:async';
import 'dart:math';

import 'package:common/bloc/app_bloc.dart';
import 'package:common/bloc/dialogflow_bloc.dart';
import 'package:courtfilechat_flutter/api/app_service_api.dart';
import 'package:courtfilechat_flutter/api/dialogflow_service_api.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main(){

  String caseNumber = "45D05-1202-MF-00061";
  String countyName = "Lake";

  List<String> searchCaseQueryList = [
    "Search case "+caseNumber+" in "+countyName+"",
    "Please search "+caseNumber+" for "+countyName+"",
  ];

  List<String> searchInvalidCaseQueryList = [
    'Search case 12312312 for hamilton',
    'Please search 78872-212-MD-2121 for hamilton',
  ];

  DialogFlowBloc _dialogFlowBloc;
  AppBloC _appBloc;

//  String _sessionId;
  String _caseNumber;
  String _countyName;


  setUpAll(() async {
    _dialogFlowBloc = DialogFlowBloc(DialogFlowServiceApi());
    _appBloc = AppBloC(AppServiceApi());
  });

  group('DialogFlow Search valid case', () {
    String _sessionId;
    setUp((){
      var uuid = new Uuid();
      _sessionId = uuid.v1();
    });

    test("search valid case", () async {
      final _random = new Random();

      String searchQuery = searchCaseQueryList[_random.nextInt(searchCaseQueryList.length)];;
      var response = await _dialogFlowBloc.sendQuery(_sessionId, searchQuery);
      expect(response, isNotNull);
      expect(response['result'], isNotNull);

      var searchResult = response['result'];

      String speechQuery = searchResult['speech'];
      expect(speechQuery, isNotNull);
      expect(speechQuery, isNotEmpty);

      var parameters = searchResult['parameters'];
      expect(speechQuery, isNotNull);

      if(speechQuery.toLowerCase().contains("we are searching")) {
        _caseNumber = parameters['caseNumber'];
        expect(_caseNumber, isNotNull);

        List countyName = parameters['countyName'];
        expect(countyName, isNotEmpty);

        _countyName = countyName[0];

        var searchResponse = await _appBloc.searchCaseService(trackingID: _caseNumber, courtOrganizationId: _countyName);
        expect(searchResponse, isNotNull);
        expect(searchResponse['caseNumber'], _caseNumber);
      }

    });

    test("show party", () async {
      String searchQuery = "Show me party";
      var response = await _dialogFlowBloc.sendQuery(_sessionId, searchQuery);
      expect(response, isNotNull);
      expect(response['result'], isNotNull);

      var searchResult = response['result'];

      String speechQuery = searchResult['speech'];
      expect(speechQuery, isNotNull);
      expect(speechQuery, isNotEmpty);

      if(speechQuery.toLowerCase().contains("we are finding party")){
        var searchResponse = await _appBloc.searchCaseService(trackingID: _caseNumber, courtOrganizationId: _countyName);
        expect(searchResponse, isNotNull);
      }

    });
  });

  group('DialogFlow Search Invalid case', () {
    String _sessionId;
    setUp((){
      var uuid = new Uuid();
      _sessionId = uuid.v1();
    });

    test("search invalid case", () async {
      final _random = new Random();

      print(_sessionId);
      String searchQuery = searchInvalidCaseQueryList[_random.nextInt(searchInvalidCaseQueryList.length)];;
      var response = await _dialogFlowBloc.sendQuery(_sessionId, searchQuery);
      expect(response, isNotNull);
      expect(response['result'], isNotNull);

      var searchResult = response['result'];

      String speechQuery = searchResult['speech'];
      expect(speechQuery, isNotNull);
      expect(speechQuery, isNotEmpty);

      var parameters = searchResult['parameters'];
      expect(speechQuery, isNotNull);
      expect(speechQuery.contains("we are searching"), true);

      _caseNumber = parameters['caseNumber'];
      expect(_caseNumber, isNotNull);

      List countyName = parameters['countyName'];
      expect(countyName, isNotEmpty);

      _countyName = countyName[0];

      var searchResponse = await _appBloc.searchCaseService(trackingID: _caseNumber, courtOrganizationId: _countyName);
      expect(searchResponse, isNotNull);
      expect(searchResponse['caseNumber'], isEmpty);
      expect(searchResponse['caseCodeDesc'], equals('No result found'));
    });
  });
}