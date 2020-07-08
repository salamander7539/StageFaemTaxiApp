import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

import 'package:faem_taxi_app/authSlidePanel/pin_auth.dart';
import 'package:faem_taxi_app/tokenData/refresh_token.dart';

import 'get_order_data.dart';

int canCode;

Future<int> cancelOrder() async {
  var url =
      "https://client.apis.stage.faem.pro/api/v2/orders/cancel/$orderUuid";
  var body = json.encode({"reason": "order_is_not_relevant"});
  var response = await http.put(url, body: body, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'source': 'android_client_app_1',
    'Authorization': 'Bearer $newToken'
  });
  if (response.statusCode == 200) {
    print(response.body);
    var jsonResponse = json.decode(response.body);
    var cCode = new CancelCode.fromJson(jsonResponse);
    canCode = cCode.cancelOrderCode;
  } else {
    print("Error with code ${response.statusCode}");
    var jsonResponse = json.decode(response.body);
    var cCode = new CancelCode.fromJson(jsonResponse);
    canCode = cCode.cancelOrderCode;
    print("${response.body}");
  }
  return canCode;
}

class CancelCode {
  var cancelOrderCode;

  CancelCode({this.cancelOrderCode});

  factory CancelCode.fromJson(Map<String, dynamic> parsedJson) {
    return CancelCode(
      cancelOrderCode: parsedJson['code'],
    );
  }
}
