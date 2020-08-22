
class Judge {
  String firstName;
  String middleInitial;
  String lastName;

  static Judge fromMap(Map<String, dynamic> data){
    Judge judge = new Judge();
    judge.firstName = data['firstName'];
    judge.middleInitial = data['middleInitial'];
    judge.lastName = data['lastName'];
    return judge;
  }

  static Map<String, dynamic> toMap(Judge judge) {
    return {
      'firstName' : judge.firstName,
      'middleInitial' : judge.middleInitial,
      'lastName' : judge.lastName,
    };
  }
}