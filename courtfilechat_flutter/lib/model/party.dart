class ChatParty {
  final int newId;
  final int caseId;
  final String companyName;
  final String partyType;
  final bool asCompany;
  final bool isNewParty;
  final bool fileAppearance;
  final bool represented;
  final bool onBehalfOf;
  final bool isLongPartyName;
  final serviceAddresses;
  final addresses;
  final representatives;
  final partyAffilations;
  final charges;
  final sentences;
  final aliases;
  final int age;
  final int id;
  final String name;

  final String address;
  bool state;

  ChatParty(
      {this.address,
      this.newId,
      this.caseId,
      this.companyName,
      this.partyType,
      this.asCompany,
      this.isNewParty,
      this.fileAppearance,
      this.represented,
      this.onBehalfOf,
      this.isLongPartyName,
      this.serviceAddresses,
      this.addresses,
      this.representatives,
      this.partyAffilations,
      this.charges,
      this.sentences,
      this.aliases,
      this.age,
      this.id,
      this.name,
      this.state = false});


      static ChatParty fromSnapshot(Map<String, dynamic> data){
          return ChatParty(
            newId: data['newId'],
            caseId: data['caseId'],
            companyName : data['companyName'],
            partyType : data['partyType'],
            asCompany: data['asCompany'] ?? false,
            isNewParty: data['isNewParty'] ?? false,
            fileAppearance: data['fileAppearance'] ?? false,
            represented: data['represented'] ?? false,
            onBehalfOf: data['onBehalfOf'] ?? false,
            isLongPartyName: data['isLongPartyName'] ?? false,
            serviceAddresses :  [], // not sure data of some variables, so just create brank 
            addresses: [],
            representatives: [],
            partyAffilations:[],
            charges: [],
            sentences: [],
            aliases: [],
            age: data['age'] ?? 0,
            id: data['id'] ?? 0,
            name: data['name'] ?? '',
          );
      }
}
