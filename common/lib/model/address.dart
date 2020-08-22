class Address {
  String seq = "";
  String line1 = "";
  String line2 = "";
  String line3 = "";
  String city = "";
  String state = "";
  String stateLabel = "";
  String zip = "";
  String country = "";
  bool primaryAddress = false;
  bool unknownAddress = false;

  Address();

  static Address fromMap(Map<dynamic, dynamic> data){
    Address address = new Address();
    address.seq = data['seq'];
    address.line1 = data['line1'];
    address.line2 = data['line2'];
    address.line3 = data['line3'];
    address.city = data['city'];
    address.state = data['state'];
    address.stateLabel = data['stateLabel'];
    address.zip = data['zip'];
    address.country = data['country'];
    address.primaryAddress = data['primaryAddress'];
    address.unknownAddress = data['unknownAddress'];

    return address;
  }

  static Map<String, dynamic> toMap(Address addressObj){
    Map addressMap = new Map();
    addressMap['seq'] = addressObj.seq;
    addressMap['line1'] = addressObj.line1;
    addressMap['line2'] = addressObj.line2;
    addressMap['line3'] = addressObj.line3;
    addressMap['city'] = addressObj.city;
    addressMap['state'] = addressObj.state;
    addressMap['stateLabel'] = addressObj.stateLabel;
    addressMap['zip'] = addressObj.zip;
    addressMap['country'] = addressObj.country;
    addressMap['primaryAddress'] = addressObj.primaryAddress;
    addressMap['unknownAddress'] = addressObj.unknownAddress;

    return addressMap;
  }
}