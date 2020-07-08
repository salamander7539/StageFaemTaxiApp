import 'package:flutter/material.dart';

import 'animations/get_smaller_animation.dart';
import 'main.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future(() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
      turnScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
    );
  }
}

Widget turnScreen() {
  return Scaffold(
    backgroundColor: Colors.black,
  );
}