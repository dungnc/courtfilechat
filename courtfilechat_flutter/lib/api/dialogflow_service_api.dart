import 'dart:async';

import 'package:common/api/dialogflow_api.dart';

class DialogFlowServiceApi extends DialogFlowApi {

  static String BASE_URL = 'https://api.dialogflow.com/v1';
  static String QUERY_URL = '/query';
  static String DEV_ACCESS_TOKEN = 'e21b75953c5f4e7a97ccf2ac3999571b';



  DialogFlowServiceApi(){
    super.setBaseApiUrl(BASE_URL);
  }

  _getHeaders() {
    return {
      "Authorization": "Bearer $DEV_ACCESS_TOKEN",
      "Content-Type": "application/json; charset=utf-8",
    };
  }

  @override
  Future<Map<dynamic, dynamic>> sendQuery(String sessionId, String content) async{
    var body = {
      "query": content,
      "sessionId": sessionId,
      "lang": "en"
    };

    return await this.postMethod(QUERY_URL, body: body, headers: _getHeaders()).then((data) async{
      return await data;
    }).catchError((error){
      throw error;
    });
  }
}