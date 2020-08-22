import 'package:common/model/base_efsp_result.dart';
import 'package:common/model/localtion_code.dart';

class LocationCodeList extends BaseEfspResult {
  List<LocationCode> locationCodeList = new List<LocationCode>();

  LocationCodeList fromJson(locationCodeListJson){
    LocationCodeList countyList = new LocationCodeList();

    List<LocationCode> locationCodeListObj = new List<LocationCode>();
    for(dynamic locationCodeJson in locationCodeListJson['locationCodeList']){
      LocationCode locationCode = new LocationCode();
      locationCodeListObj.add(locationCode.fromJson(locationCodeJson));
    }

    countyList.locationCodeList = locationCodeListObj;

    return countyList;
  }

  Map toMap(LocationCodeList locationCodeListObject){
    Map locationCodeListMap = new Map();
    List<Map> locationCodeList = new List<Map>();

    for(LocationCode locationCode in locationCodeListObject.locationCodeList){
      locationCodeList.add(locationCode.toMap(locationCode));
    }

    locationCodeListMap['locationCodeList'] = locationCodeList;

    return locationCodeListMap;
  }
}