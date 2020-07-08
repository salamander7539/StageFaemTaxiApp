import 'package:faem_taxi_app/addresses_screen.dart';
import 'package:faem_taxi_app/await_taxi_screen.dart';
import 'package:faem_taxi_app/hello_page.dart';
import 'package:faem_taxi_app/home_addresses_page.dart';
import 'package:faem_taxi_app/tokenData/refresh_token.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'animations/get_smaller_animation.dart';
import 'authSlidePanel/countries_drop_down.dart';
import 'authSlidePanel/phone_auth.dart';
import 'authSlidePanel/pin_auth.dart';

void main() => runApp(MyApp());

var name, userName, num, pin, fcmToken;
String transferNumber;
var orderState;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/page1": (context) => MyHomePage(),
        "/page2": (context) => MyAddress(),
        "/page3": (context) => AwaitTaxi(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeAddressesScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PanelController _pc1 = new PanelController();
  PanelController _pc2 = new PanelController();
  bool _visible = true;
  var answerOrderState;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future _showNotification(Map<String, dynamic> message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'channel id',
      'channel name',
      'channel desc',
      importance: Importance.Max,
      priority: Priority.High,
    );

    var platformChannelSpecifics =
        new NotificationDetails(androidPlatformChannelSpecifics, null);
    await flutterLocalNotificationsPlugin.show(
      0,
      message['notification']['title'],
      message['notification']['body'],
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  getToken() async {
    String token = await _firebaseMessaging.getToken();
    fcmToken = token;
    print("FCM-token: $fcmToken");
  }

  Future selectNotification(String payload) async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  @override
  void initState() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettings =
        InitializationSettings(initializationSettingsAndroid, null);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
    super.initState();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        setState(() {
          var data = message['data'];
          var payload = json.decode(data['payload']);
          var orderState = payload['state_title'];
          print("ANSWER: $orderState");
        });
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
    );
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    const colorTextField = Color(0xFFE5E5E5);
    const colorText = Color(0xFF5A5A5A);
    const textFieldColor = Color(0xFFBFBFC1);
    const primeColor = Color(0xFFF5F5F5);
    const sliderColor = Color(0xFFF3F2F8);

    var screenSize = MediaQuery.of(context).size;

    BorderRadiusGeometry radiusGeometry = BorderRadius.only(
        topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0));
    return Scaffold(
      backgroundColor: primeColor,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 100.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Введите ваше имя",
                    style: TextStyle(
                        fontSize: 30.0,
                        color: colorText,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Divider(
                  color: Colors.white,
                  height: 40,
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextField(
                    autofocus: true,
                    onSubmitted: (String newName) {
                      if (newName != null) {
                        userName = newName;
                        setState(() {});
                        GetPageSmall(widget: MyHomePage());
                        _visible = true;
                        _pc1.open();
                      }
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(7.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(7.0)),
                      ),
                      filled: true,
                      fillColor: colorTextField,
                      hintText: "Ваше имя",
                      hintStyle: TextStyle(color: textFieldColor),
                    ),
                  ),
                )
              ],
            ),
          ),
          Visibility(
            maintainState: true,
            maintainAnimation: true,
            visible: _visible,
            child: SlidingUpPanel(
              margin: EdgeInsets.only(left: 16.0, right: 16.0),
//              onPanelOpened: () {
//                GetPageSmall(widget: MyHomePage());
//              },
              header: SizedBox(
                height: 60.0,
                width: MediaQuery.of(context).size.width * 0.925,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: radiusGeometry,
                    color: Color(0xFFFAFAFA),
                    border: Border.all(
                      color: Color(0xFFCAC9CE),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {},
                        child: Text(
                          "< Назад",
                          style: TextStyle(
                            color: Color(0xFF6099F7),
                            fontSize: 15.0,
                            fontFamily: "Helvetica",
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "Введите номер телефона",
                          style: TextStyle(
                            color: Color(0xFF424242),
                            fontSize: 15.0,
                            fontFamily: "Helvetica",
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      FlatButton(
                        onPressed: () {},
                        child: Text(
                          "Далее",
                          style: TextStyle(
                            color: Color(0xFF6099F7),
                            fontSize: 15.0,
                            fontFamily: "Helvetica",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              color: sliderColor,
              backdropEnabled: true,
              controller: _pc1,
              maxHeight: 720.0,
              minHeight: 40.0,
              borderRadius: radiusGeometry,
              panel: Wrap(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color(0xFFE2E2E7)),
                    ),
                    margin: EdgeInsets.only(top: 100.0),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Text(
                            "Страна:",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Color(0xFF595959),
                            ),
                          ),
                          title: DropDownOptionMenu(),
                        ),
                        Divider(
                          color: Color(0xFFEDEDED),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ListTile(
                            leading: Text(
                              "Номер \nтелефона",
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Color(0xFF595959),
                              ),
                            ),
                            title: TextField(
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                              maxLength: 11,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                prefix: Icon(
                                  Icons.add,
                                  size: 14,
                                ),
                                hintText: "Номер телефона",
                              ),
                              onSubmitted: (String newNumber) async {
                                num = newNumber;
                                if (num.length == 11) {
                                  transferNumber = "+" + num;
//                              Number number = Number(number: "+" + num);
                                  await loadAuthData(userName, "+" + num);
                                  transferNumber = "+" + num;
                                  _pc1.close();
                                  _visible = false;
                                  setState(() {});
                                  _pc2.open();
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              collapsed: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: radiusGeometry,
                ),
                child: Center(
                  child: Icon(
                    Icons.linear_scale,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            maintainState: true,
            maintainAnimation: true,
            visible: !_visible,
            child: SlidingUpPanel(
              margin: EdgeInsets.only(left: 16.0, right: 16.0),
              backdropEnabled: true,
              controller: _pc2,
              maxHeight: 720.0,
              minHeight: 40.0,
              header: SizedBox(
                height: 60.0,
                width: MediaQuery.of(context).size.width * 0.925,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: radiusGeometry,
                    color: Color(0xFFFAFAFA),
                    border: Border.all(
                      color: Color(0xFFCAC9CE),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {},
                        child: Text(
                          "< Назад",
                          style: TextStyle(
                            color: Color(0xFF6099F7),
                            fontSize: 15.0,
                            fontFamily: "Helvetica",
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "Подтвердите номер телефона",
                          style: TextStyle(
                            color: Color(0xFF424242),
                            fontSize: 15.0,
                            fontFamily: "Helvetica",
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      FlatButton(
                        onPressed: () {},
                        child: Text(
                          "Подтвердить",
                          style: TextStyle(
                            color: Color(0xFF6099F7),
                            fontSize: 15.0,
                            fontFamily: "Helvetica",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              borderRadius: radiusGeometry,
              panel: Padding(
                padding: const EdgeInsets.only(top: 150.0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Введит код из СМС, который был выслан по номеру \n",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Divider(
                            color: Colors.white,
                            height: 20,
                          ),
                          PinInputTextField(
                            autoFocus: true,
                            pinLength: 4,
                            keyboardType: TextInputType.phone,
                            inputFormatter: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            decoration: UnderlineDecoration(),
                            onSubmit: (String newPin) async {
                              pin = newPin;
                              int pinCode = int.parse(pin);
                              await loadCode(userName, pinCode);
                              await getTokenData(refToken);
                              if (status == 200) {
                                Navigator.push(
                                    context, GetPageSmall(widget: MyAddress()));
                              }
                              _pc2.close();
                              _visible = true;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              collapsed: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: radiusGeometry,
                ),
                child: Center(
                  child: Icon(
                    Icons.linear_scale,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Name {
  String userName;

  Name({this.userName});
}

class Number {
  final String number;

  Number({this.number});
}
