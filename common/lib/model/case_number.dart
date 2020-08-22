class CaseNumber{
  String id = "";
  String caseNumber = "";

  static CaseNumber fromMap(Map<String, dynamic> data){
    CaseNumber caseNumber = new CaseNumber();

    caseNumber.id = data['id'];
    caseNumber.caseNumber = data['caseNumber'];

    return caseNumber;
  }

  static Map<String, dynamic> toMap(CaseNumber caseNumber) {
    return {
      'id' : caseNumber.id,
      'caseNumber' : caseNumber.caseNumber
    };
  }
}