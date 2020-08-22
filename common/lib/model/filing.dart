import 'package:common/model/case_number.dart';

class Filing {
  String pendingCaseNumber = "";
  CaseNumber caseNumber = new CaseNumber();
  String filingId = "";
  DateTime filingDate = new DateTime.now();
  String caseCaption = "";
  int caseId = 0;
  String caseTrackingId = "";
  int caseType = 0;
  int caseCode = 0;
  int filer = 0;
  String filingType = "";
  String status = "";

  static Filing fromMap(Map<String, dynamic> data){
    Filing filing = new Filing();
    if(data['caseNumber'] != null){
      filing.caseNumber.caseNumber = data['caseNumber']['caseNumber'];
    }
    filing.pendingCaseNumber = data['pendingCaseNumber'];
    filing.filingDate = data['filingDate'];
    filing.caseCaption = data['caseCaption'];
    filing.caseId = int.parse(data['caseId'].toString());
    filing.caseCode = int.parse(data['caseCode'].toString());
    filing.filer = int.parse(data['filer'].toString());
    filing.caseTrackingId = data['caseTrackingId'];
    filing.caseType = data['caseType'];
    filing.filingType = data['filingType'];
    filing.filingId = data['filingId'];
    filing.status = data['status'];
    return filing;
  }

  static Map<String, dynamic> toMap(Filing filing) {
    return {
      'caseNumber' :{
        'caseNumber' : filing.caseNumber.caseNumber
      },
      'pendingCaseNumber' : filing.pendingCaseNumber,
      'filingId': filing.filingId,
      'filingDate': filing.filingDate,
      'caseCaption': filing.caseCaption,
      'caseId': filing.caseId,
      'caseCode': filing.caseCode,
      'filer': filing.filer,
      'caseTrackingId': filing.caseTrackingId,
      'caseType': filing.caseType,
      'filingType': filing.filingType,
      'status': filing.status
    };
  }
}