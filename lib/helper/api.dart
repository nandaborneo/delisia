import 'package:delisia/helper/session.dart';
import 'package:http/http.dart' as http;

class Api {
  static final String apiEndpoint = 'http://172.25.82.186/delisiaserver/';
  static Future<String> httpPost(
      String serviceName, Map<String, dynamic> data) async {
    var responseBody = '{"data": [], "success": false, "message": ""}';
    var accessToken = await Session.getAccessToken();
    try {
      var response = await http.post('$serviceName',
          headers: {
            'Authorization': '$accessToken',
            'Accept': 'application/json',
            // 'Content-Type': 'application/json'
          },
          body: data);

      if (response.statusCode == 200) {
        responseBody = response.body;
      }
    } catch (e) {
      throw new Exception("HTTP POST ERROR");
    }

    return responseBody;
  }

  static Future<String> httpGet(String serviceName) async {
    var responseBody = '{"data": [], "success": false, "message": ""}';
    var accessToken = await Session.getAccessToken();
    try {
      var response = await http.get(
        '$serviceName',
        headers: {
          'Authorization': '$accessToken',
          'Accept': 'application/json',
          // 'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        responseBody = response.body;
      }
    } catch (e) {
      throw new Exception("HTTP GET ERROR");
    }

    return responseBody;
  }
}
