import 'package:http/http.dart' as http;
import 'package:faem_taxi_app/tokenData/fcm_token.dart';
import 'dart:convert';
import 'dart:async';

import 'package:faem_taxi_app/addresses_screen.dart';

import 'package:faem_taxi_app/tokenData/refresh_token.dart';
import 'package:faem_taxi_app/main.dart';

var orderUuid;

Future<void> createOrder() async {
  await sendFcm(fcmToken);
  var jsonBody = json.encode({
    "callback_phone": transferNumber,
    "comment": "Просит побыстрей",
    "routes": [
      {
        "unrestricted_value": addUnrestricted_value,
        "value": addValue,
        "country": addCountry,
        "region": addRegion,
        "region_type": addRegion_type,
        "city": addCity,
        "city_type": addCity_type,
        "street": addStreet,
        "street_type": addStreet_type,
        "street_with_type": addStreet_with_type,
        "house": addHouse,
        "out_of_town": addOut_of_town,
        "house_type": addHouse_type,
        "accuracy_level": addAccuracy_level,
        "radius": addRadius,
        "lat": addLat,
        "lon": addLon,
      },
      {
        "unrestricted_value": destUnrestricted_value,
        "value": destValue,
        "country": destCountry,
        "region": destRegion,
        "region_type": destRegion_type,
        "city": destCity,
        "city_type": destCity_type,
        "street": destStreet,
        "street_type": destStreet_type,
        "street_with_type": destStreet_with_type,
        "house": destHouse,
        "out_of_town": destOut_of_town,
        "house_type": destHouse_type,
        "accuracy_level": destAccuracy_level,
        "radius": addRadius,
        "lat": destLat,
        "lon": destLon
      }
    ],
    "service_uuid": "44db4a2b-c33b-4323-9ee7-7b4864179192"
  });
  var url = "https://client.apis.stage.faem.pro/api/v2/orders";
  var response = await http.post(url, body: jsonBody, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'source': 'android_client_app_1',
    'Authorization': 'Bearer $newToken'
  });
  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    var order = new OrderData.fromJson(jsonResponse);
    orderUuid = order.uuid;
    print(jsonBody);
  } else {
    print("Error get order with code ${response.statusCode}");
    print("${response.body}");
  }
}

class OrderData {
  final String uuid;

  OrderData({this.uuid});

  factory OrderData.fromJson(Map<String, dynamic> parsedJson) {
    return OrderData(
      uuid: parsedJson['uuid'] as String,
    );
  }
}
