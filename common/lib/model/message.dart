class Message{
  dynamic content;
  String idFrom;
  String idTo;
  String timestamp;
  int type;
  String featureType;


 
  static Message fromMap(Map<String, dynamic> data){
    Message message = new Message();

    message.content = data['content'];
    message.idFrom  = data['idFrom'];
    message.idTo = data['idTo'];
    message.timestamp = data['timestamp'];
    message.type = data['type'];
    message.featureType = data['featureType'];

    return message;
  }

  static Map<String, dynamic> toMap(Message message) {
    return {
      'content' : message.content,
      'idFrom' : message.idFrom,
      'idTo' : message.idTo,
      'timestamp' : message.timestamp,
      'type' : message.type,
      'featureType' : message.featureType
    };
  }
}