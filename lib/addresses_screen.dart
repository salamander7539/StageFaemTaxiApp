import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:faem_taxi_app/tokenData/refresh_token.dart';
import 'jsons/get_addresses.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

import 'jsons/get_order.dart';
import 'jsons/get_order_data.dart';

class MyAddress extends StatefulWidget {
  @override
  _MyAddressState createState() => _MyAddressState();
}

var addressResponse,
    destinationResponse,
    transferAddressData,
    transferDestinationData;

var addUnrestricted_value,
    addValue,
    addCountry,
    addRegion,
    addRegion_type,
    addCity,
    addCity_type,
    addStreet,
    addStreet_type,
    addStreet_with_type,
    addHouse,
    addOut_of_town,
    addHouse_type,
    addAccuracy_level,
    addRadius,
    addLat,
    addLon;

var destUnrestricted_value,
    destValue,
    destCountry,
    destRegion,
    destRegion_type,
    destCity,
    destCity_type,
    destStreet,
    destStreet_type,
    destStreet_with_type,
    destHouse,
    destOut_of_town,
    destHouse_type,
    destAccuracy_level,
    destRadius,
    destLat,
    destLon;

class _MyAddressState extends State<MyAddress> {
  String myAddress, destinationMark;
  AutoCompleteTextField searchTextField;
  AutoCompleteTextField searchTextField1;
  GlobalKey<AutoCompleteTextFieldState<AddressData>> key = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<AddressData>> key1 = new GlobalKey();

  static List<AddressData> addresses = new List<AddressData>();
  bool loading = true;

  void getAddresses(String name) async {
    try {
      var url = "https://crm.apis.stage.faem.pro/api/v2/addresses";
      var jsonBody = json.encode({"name": name});
      final response =
      await http.post(url, body: jsonBody, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
      if (response.statusCode == 200) {
        addresses = loadAddresses(response.body);
        var jsonResponse = json.decode(response.body);
        transferAddressData = jsonResponse[0];
        var add = new AddressData.fromJson(transferAddressData);
        addUnrestricted_value = add.unrestricted_value;
        addValue = add.value;
        addCountry = add.country;
        addRegion = add.region;
        addRegion_type = add.region_type;
        addCity = add.city;
        addCity_type = add.city_type;
        addStreet = add.street;
        addStreet_type = add.street_type;
        addStreet_with_type = add.street_with_type;
        addHouse = add.house;
        addOut_of_town = add.out_of_town;
        addHouse_type = add.house_type;
        addAccuracy_level = add.accuracy_level;
        addRadius = add.radius;
        addLat = add.lat;
        addLon = add.lon;
        print("Addresses: ${addresses.length}");
        setState(() {
          loading = false;
        });
        if (key.currentState != null) {
          key.currentState.suggestions = addresses;
          key.currentState.setState(() {});
        }
        print(loading);
      } else {
        print("Error with code ${response.statusCode}");
      }
    } catch (e) {
      print("Error get addresses");
    }
  }

  void getDestination(String name) async {
    try {
      var url = "https://crm.apis.stage.faem.pro/api/v2/addresses";
      var jsonBody = json.encode({"name": name});
      final response =
      await http.post(url, body: jsonBody, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
      if (response.statusCode == 200) {
        addresses = loadDestination(response.body);
        var jsonResponse = json.decode(response.body);
        transferDestinationData = jsonResponse[0];
        var dest = new AddressData.fromJson(transferDestinationData);
        destUnrestricted_value = dest.unrestricted_value;
        destValue = dest.value;
        destCountry = dest.country;
        destRegion = dest.region;
        destRegion_type = dest.region_type;
        destCity = dest.city;
        destCity_type = dest.city_type;
        destStreet = dest.street;
        destStreet_type = dest.street_type;
        destStreet_with_type = dest.street_with_type;
        destHouse = dest.house;
        destOut_of_town = dest.out_of_town;
        destHouse_type = dest.house_type;
        destAccuracy_level = dest.accuracy_level;
        destRadius = dest.radius;
        destLat = dest.lat;
        destLon = dest.lon;
        print("Destinations: ${addresses.length}");
        setState(() {
          loading = false;
        });
        if (key1.currentState != null) {
          key1.currentState.suggestions = addresses;
          key1.currentState.setState(() {});
        }
        print(loading);
      } else {
        print("Error with code ${response.statusCode}");
      }
    } catch (e) {
      print("Error get addresses");
    }
  }

  static List<AddressData> loadAddresses(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed
        .map<AddressData>((json) => AddressData.fromJson(json))
        .toList();
  }

  static List<AddressData> loadDestination(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed
        .map<AddressData>((json) => AddressData.fromJson(json))
        .toList();
  }

  Widget row(AddressData addressData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          height: 50.0,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              addressData.unrestricted_value,
              style: TextStyle(
                fontSize: 20.0,
              ),
              softWrap: true,
            ),
          ),
        ),
        SizedBox(
          width: 15.0,
          height: 50.0,
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    getAddresses("");
    getDestination("");
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 100.0),
          child: Column(
            children: <Widget>[
              Text(
                "Введите адрес",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 16.0, right: 20.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: loading
                          ? CircularProgressIndicator()
                          : searchTextField =
                          AutoCompleteTextField<AddressData>(
                            key: key,
                            textChanged: (String value) {
                              if (value.length > 0) {
                                getAddresses(value);
                              }
                            },
                            clearOnSubmit: false,
                            suggestions: addresses,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                            decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                              hintText: "Поиск адресов...",
                              hintStyle: TextStyle(color: Colors.black),
                            ),
                            itemFilter: (item, query) {
                              return item.unrestricted_value
                                  .toLowerCase()
                                  .startsWith(query.toLowerCase());
                            },
                            itemSorter: (a, b) {
                              return a.unrestricted_value
                                  .compareTo(b.unrestricted_value);
                            },
                            itemBuilder: (context, item) {
                              return row(item);
                            },
                            itemSubmitted: (item) {
                              setState(() {
                                searchTextField.textField.controller.text =
                                    item.unrestricted_value;
                                getAddresses(searchTextField
                                    .textField.controller.text);
                              });
                            },
                          ),
                    )
                  ],
                ),
              ),
              Divider(
                color: Colors.white,
              ),
              Divider(
                color: Colors.white,
              ),
              Text(
                "Точка назначения",
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 16.0,
                  right: 20.0,
                ),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: loading
                          ? CircularProgressIndicator()
                          : searchTextField1 =
                          AutoCompleteTextField<AddressData>(
                            key: key1,
                            textChanged: (String value) {
                              if (value.length > 0) {
                                getDestination(value);
                              }
                            },
                            clearOnSubmit: false,
                            suggestions: addresses,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                            decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                              hintText: "Поиск адресов...",
                              hintStyle: TextStyle(color: Colors.black),
                            ),
                            itemFilter: (item, query) {
                              return item.unrestricted_value
                                  .toLowerCase()
                                  .startsWith(query.toLowerCase());
                            },
                            itemSorter: (a, b) {
                              return a.unrestricted_value
                                  .compareTo(b.unrestricted_value);
                            },
                            itemBuilder: (context, item) {
                              return row(item);

                            },
                            itemSubmitted: (item) {
                              setState(() {
                                searchTextField1.textField.controller.text =
                                    item.unrestricted_value;
                                getDestination(searchTextField1
                                    .textField.controller.text);
                              });
                            },
                          ),
                    )
                  ],
                ),
              ),
              ListTile(
                leading: Text(
                  "Способ оплаты:",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                title: Text("Наличные",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    )),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async{
          Path path = Path(
            myAddress: searchTextField.textField.controller.text,
            destinationMark: searchTextField1.textField.controller.text,
          );
          print(destUnrestricted_value);
          await getTokenData(newRefToken);//Рефреш токен
          //отправка FCM
          await createOrder();//создание заказа
          await getOrder();//получение данных(отслеживание)
          if (searchTextField.textField.controller.text != "" ||
              searchTextField1.textField.controller.text != "") {
            Navigator.pushNamed(context, "/page3", arguments: path);
          }
        },
        backgroundColor: Colors.blueGrey,
        label: Text(
          "Заказать такси",
          style: TextStyle(color: Colors.white, fontSize: 22.0),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class Path {
  final String myAddress;
  final String destinationMark;
  final String orderStatus;

  Path({
    this.myAddress,
    this.destinationMark,
    this.orderStatus
  });
}
