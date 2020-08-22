import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import '../base/';
class BaseApi {
  String _baseApiUrl = "";

  void setBaseApiUrl(String baseApiUrl) {
    _baseApiUrl = baseApiUrl;
  }

  Future<dynamic> getMethod(url, {body}) async {
     var bodyUri = "";
     Uri uri;

     if(body != null){
       uri = new Uri(queryParameters : body);
       bodyUri = uri.toString();
       url = url + bodyUri;
     }
    print(url);
    return http.get("$_baseApiUrl$url").then((http.Response response) {
      var body = response.body != null ? json.decode(response.body) : null;
      int statusCode = response.statusCode;
      print('statusCode $statusCode');
      if (200 >= statusCode && statusCode <= 299) {
        // success code
        // response.
        return json.decode(response.body);
      }
      if (400 <= statusCode && statusCode <= 499) {

      throw Exception('bad request');
        // request error
        // switch (response.statusCode) {
        //   case 401:
        //   case 403:
        //     throw new ApiAuthorizationException(
        //         statusCode: response.statusCode,
        //         errorCode: body["errorCode"],
        //         message: body["message"] ?? body["error_description"] ?? "");
        //     break;
        //   default:
        //     throw new ApiRequestException(
        //         statusCode: response.statusCode,
        //         errorCode: body["errorCode"],
        //         message: body["message"]);
        // }
      } else if (500 <= response.statusCode && response.statusCode <= 599) {
        // server error
         throw Exception('server error');
      } else {
        // unknown error
         throw Exception('unknown error');
      }
    });
  }

  Future<dynamic> postMethod(url,
      {param, body, headers, noJsonEncode = false}) async {
    var bodyUri = "";
    Uri uri;

    if (param != {}) {
      uri = new Uri(queryParameters: param);
      bodyUri = uri.toString();
    }

    if (noJsonEncode) {
      body = body;
    } else {
      body = json.encoder.convert(body);
    }

    var apiResponse;
    try {
      await http
          .post(_baseApiUrl + url + bodyUri, headers: headers, body: body)
          .then((http.Response response) {
        try {
          apiResponse = json.decode(response.body);
        } catch (e) {
          return apiResponse;
        }
        if (apiResponse != null && (apiResponse is Map)) {
          if (apiResponse.containsKey('cause')) {
            throw handleError(apiResponse['cause']);
          }
        }
      }).catchError((e) {
        throw handleError(e);
      });
    } catch (e) {
      throw handleError(e);
    }

    return apiResponse;
  }

  Exception handleError(dynamic e) {
    return e;
  }
}
