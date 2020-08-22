import 'package:common/model/address.dart';

class Party {
  int newId;
  int caseId;
  String partyCode;
  String partyCodeDesc;
  String companyName;
  String partyType;
  bool asCompany;
  bool isNewParty;
  bool fileAppearance;
  bool represented;
  bool onBehalfOf; 
  bool isLongPartyName;
  String lastName;
  String firstName;
  String middleInitial;
  List<Address> addresses = new List<Address>();

  static Party fromMap(Map<dynamic, dynamic> data){
    Party party = new Party();
    party.newId = data['newId'];
    party.caseId = data['caseId'];
    party.partyCode = data['partyCode'];
    party.partyCodeDesc = data['partyCodeDesc'];
    party.companyName = data['companyName'];
    party.partyType = data['partyType'];
    party.asCompany = data['asCompany'];
    party.isNewParty = data['isNewParty'];
    party.fileAppearance = data['fileAppearance'];
    party.represented = data['represented'];
    party.onBehalfOf = data['onBehalfOf'];
    party.isLongPartyName = data['isLongPartyName'];
    party.firstName = data['firstName'];
    party.lastName = data['lastName'];
    party.middleInitial = data['middleInitial'];

    List<Address> addressList = new List<Address>();
    for(var address in data['addresses']){
      addressList.add(Address.fromMap(address));
    }

    party.addresses = addressList;

    return party;
  }

  static Map<String, dynamic> toMap(Party party) {

    List<Map<String, dynamic>> addressList = new List<Map<String, dynamic>>();
    for(Address address in party.addresses){
      addressList.add(Address.toMap(address));
    }

    return {
      "newId" : party.newId,
      "caseId" : party.caseId,
      "partyCode" : party.partyCode,
      "partyCodeDesc" : party.partyCodeDesc,
      "companyName" : party.companyName,
      "partyType" : party.partyType,
      "asCompany" : party.asCompany,
      "isNewParty" : party.isNewParty,
      "fileAppearance" : party.fileAppearance,
      "represented" : party.represented,
      "onBehalfOf" : party.onBehalfOf,
      "isLongPartyName" : party.isLongPartyName,
      "firstName" : party.firstName,
      "lastName" : party.lastName,
      "middleInitial" : party.middleInitial,
      "addresses" : addressList
    };
  }

}