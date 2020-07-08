import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

int pinAnswerCode, status;
String refToken, token;

Future<TokenData> loadCode(String deviceId, var code) async {
  TokenData getToken;
  var jsonRequest = json.encode({
    "device_id": deviceId,
    "code": code
  });
  var url = "https://client.apis.stage.faem.pro/api/v2/auth/verification";
  var response = await http.post(url, body: jsonRequest, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  });
  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    getToken = new TokenData.fromJson(jsonResponse);
    token = getToken.token;
    status = response.statusCode;
    refToken = getToken.refresh_token;
    print("refToken: $refToken");
  } else {
    status = response.statusCode;
    print('Request failed with status: ${response.statusCode}.');
  }
  return getToken;
}

class TokenData {
  // ignore: non_constant_identifier_names
  final String token;
  final String client_uuid;
  final String refresh_token;
  final int refresh_expiration;

  TokenData({this.token, this.client_uuid, this.refresh_token, this.refresh_expiration});

  factory TokenData.fromJson(Map<String, dynamic> parsedJson) {
    return TokenData(
      token: parsedJson["token"] as String,
      client_uuid: parsedJson["client_uuid"] as String,
      refresh_token: parsedJson["refresh_token"] as String,
      refresh_expiration: parsedJson["refresh_expiration"] as int,
    );
  }
}
