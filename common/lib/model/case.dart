import 'package:common/model/judge.dart';
import 'package:common/model/party.dart';

class Case {
  String caseNumber;
  String caseId;
  String caseCodeDesc;
  String status;
  String caseCaption;
  String caseType;
  String caseTrackingId;
  String countyCode;
  Judge judge;
  Party party;

  static Case fromMap(Map<String, dynamic> data){
    Case caseObject = new Case();
    caseObject.caseNumber = data['caseNumber'];
    caseObject.caseId = data['caseId'];
    caseObject.caseCodeDesc = data['caseCodeDesc'];
    caseObject.status = data['status'];
    caseObject.caseCaption = data['caseCaption'];
    caseObject.caseType = data['caseType'];
    caseObject.caseTrackingId = data['caseTrackingId'];
    caseObject.countyCode = data['countyCode'];
    caseObject.judge = Judge.fromMap(data['judge']);
    caseObject.party = Party.fromMap(data['party']);
    return caseObject;
  }

  static Map<String, dynamic> toMap(Case caseObj) {
    return {
      'caseNumber' : caseObj.caseNumber,
      'caseId' : caseObj.caseId,
      'caseCodeDesc' : caseObj.caseCodeDesc,
      'status' : caseObj.status,
      'caseCaption' : caseObj.caseCaption,
      'caseType' : caseObj.caseType,
      'caseTrackingId' : caseObj.caseTrackingId,
      'countyCode' : caseObj.countyCode,
      'judge' : Judge.toMap(caseObj.judge),
      'party' : Party.toMap(caseObj.party),
    };
  }

}