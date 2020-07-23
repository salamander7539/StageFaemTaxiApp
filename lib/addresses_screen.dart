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
  bool _isVisible = false;
  bool active = true;
  bool toggleActive = true;

  void showToast() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

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
                fontWeight: FontWeight.bold,
                color: Color(0xFF595959),
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
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 60.0),
          child: Column(
            children: <Widget>[
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
                                color: Color(0xFF595959),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                                labelText: "Ваше местоположение",
                                labelStyle: TextStyle(
                                  color: Color(0xFFB2B2B2),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
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
                    ),
                  ],
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
                                color: Color(0xFF595959),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                                labelText: "Точка назначения",
                                labelStyle: TextStyle(
                                  color: Color(0xFFB2B2B2),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
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
              Divider(
                color: Colors.transparent,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        showToast();
                        setState(() {
                          active = !active;
                        });
                      },
                      shape: CircleBorder(
                        side: BorderSide(color: Colors.transparent),
                      ),
                      color: active ? Color(0xFFF5F5F5) : Color(0xFF6099F7),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.filter_list,
                          color: active ? Color(0xFF6099F7) : Color(0xFFF5F5F5),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _isVisible,
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            toggleActive = !toggleActive;
                          });
                        },
                        child: Text(
                          "Тарифы",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: !toggleActive ? Color(0xFFDCDCDC) : Color(0xFF6099F7),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _isVisible,
                      child: FlatButton(
                        onPressed: () {
                          setState(() {
                            toggleActive = !toggleActive;
                          });
                        },
                        child: Text(
                          "Опции",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: toggleActive ? Color(0xFFDCDCDC) : Color(0xFF6099F7),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 75.0, right: 25.0),
                      child: Text(
                        "95 ₽",
                        style: TextStyle(
                          color: Color(0xFF6099F7),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 16.0, right: 20.0),
                child: Divider(
                  color: Color(0xFFBCBCBC),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 16.0, right: 20.0),
                child: AbsorbPointer(
                  absorbing: false,
                  child: TextFormField(
                    readOnly: true,
                    initialValue: "Наличными",
                    style: TextStyle(color: Color(0xFFD0D0D0)),
                    decoration: InputDecoration(
                      labelText: "Способ оплаты",
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFBCBCBC),
                          fontSize: 20.0),
                      hintText: "Наличными",
                      hintStyle: TextStyle(color: Color(0xFFD0D0D0)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFEDEDED)),
                      ),
                      disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFEDEDED)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FlatButton(
        onPressed: () async {
          Path path = Path(
            myAddress: searchTextField.textField.controller.text,
            destinationMark: searchTextField1.textField.controller.text,
          );
          print(destUnrestricted_value);
          await getTokenData(newRefToken); //Рефреш токен
          //отправка FCM
          await createOrder(); //создание заказа
          await getOrder(); //получение данных(отслеживание)
          if (searchTextField.textField.controller.text != "" ||
              searchTextField1.textField.controller.text != "") {
            Navigator.pushNamed(context, "/page3", arguments: path);
          }
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(36.0),
        ),
        color: Color(0xFF6099F7),
        child: Padding(
          padding: const EdgeInsets.only(
              bottom: 14.0, top: 14.0, left: 22.0, right: 22.0),
          child: Text(
            "Заказать такси",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
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

  Path({this.myAddress, this.destinationMark, this.orderStatus});
}
