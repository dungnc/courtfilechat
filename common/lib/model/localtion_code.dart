import 'package:common/model/code_label.dart';

class LocationCode extends CodeLabel{
  String odysseyNodeId;
  String cmsId;
  String parentNodeId;
  bool initial;
  bool subsequent;
  bool allowFilingIntoNonindexedcase;
  String allowableCardTypes;
  bool sendServiceBeforeReview;
  bool county;
  bool restrictBankAccountPayment;
  bool allowMultipleAttorneys;
  bool sendServiceContactRemovedNotifications;

  LocationCode fromJson(Map locationCodeJson){
    LocationCode locationCode = new LocationCode();
    locationCode.odysseyNodeId = locationCodeJson['odysseyNodeId'];
    locationCode.cmsId = locationCodeJson['cmsId'];
    locationCode.parentNodeId = locationCodeJson['parentNodeId'];
    locationCode.initial = locationCodeJson['initial'];
    locationCode.subsequent = locationCodeJson['subsequent'];
    locationCode.allowFilingIntoNonindexedcase = locationCodeJson['allowFilingIntoNonindexedcase'];
    locationCode.allowableCardTypes = locationCodeJson['allowableCardTypes'];
    locationCode.county = locationCodeJson['county'];
    locationCode.restrictBankAccountPayment = locationCodeJson['restrictBankAccountPayment'];
    locationCode.allowMultipleAttorneys = locationCodeJson['allowMultipleAttorneys'];
    locationCode.sendServiceContactRemovedNotifications = locationCodeJson['sendServiceContactRemovedNotifications'];
    locationCode.code = locationCodeJson['code'];
    locationCode.label = locationCodeJson['label'];
    locationCode.errorCode = locationCodeJson['errorCode'];
    locationCode.errorMessage = locationCodeJson['errorMessage'];
    return locationCode;
  }

  Map toMap(LocationCode locationCode){
    return locationCode.toMap(locationCode);
  }

}
