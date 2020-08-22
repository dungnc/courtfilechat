import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

const kBaseUrl = 'https://api.dialogflow.com/v1';
const kQuery = '/query';
const kDevAccessToken = 'e21b75953c5f4e7a97ccf2ac3999571b';

class DialogFlowApi {
  final String baseUrl;
  DialogFlowApi({this.baseUrl: kBaseUrl});

  _geteaders() {
    return {
      "Authorization": "Bearer $kDevAccessToken",
      "Content-Type": "application/json; charset=utf-8",
    };
  }

  query({@required String content, @required String sessionId}) {
    return http.post("$kBaseUrl$kQuery", headers: _geteaders(), body: json.encode({
      "query": content,
      "sessionId": sessionId,
      "lang": "en"
    })).then((response) {
      return _processResponse(response);
    });
  }

  _processResponse(response){
    print("response ${response.data ?? ''}");
    var body = response.body != null ? json.decode(response.body) : null;
    return body;
    // print("body ${body['result']}");
    // return body;
  }
}


