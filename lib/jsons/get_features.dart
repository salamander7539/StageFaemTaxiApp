import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'get_options_model.dart';

var names;

Future getServices() async {
  var url = "https://client.apis.stage.faem.pro/api/v2/options";
  final response = await http.get(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  });
  if (response.statusCode == 200) {
//    print(response.body);
//    var getOptions = getOptionsFromJson(response.body) as List;
//    List<Service> optService = getOptions.map((servJson) => Service.fromJson(servJson)).toList();
//    print(optService);

    var featureResponse = json.decode(response.body)['features'] as List;
    List<Feature> featureObj =
    featureResponse.map((featureJson) => Feature.fromJson(featureJson)).toList();

    print(featureObj);
  } else {
    return null;
  }
}


