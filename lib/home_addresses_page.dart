import 'package:flutter/material.dart';

class HomeAddressesScreen extends StatefulWidget {
  @override
  _HomeAddressesScreenState createState() => _HomeAddressesScreenState();
}

class _HomeAddressesScreenState extends State<HomeAddressesScreen> {
  int _currentIndex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Container(
        margin: EdgeInsets.only(top: 280.0, left: 24.0, right: 24.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                hintText: "Ваше местоположение",
                hintStyle: TextStyle(fontSize: 20.0),
                suffix: FlatButton(
                  shape: CircleBorder(
                    side: BorderSide(color: Colors.transparent),
                  ),
                  color: Color(0xFFE5E5E5),
                  onPressed: () {  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.create,
                      color: Color(0xFF6B6B6B),
                    ),
                  ),
                ),
                labelText: "Ваше местоположение",
                labelStyle: TextStyle(color: Color(0xFFB2B2B2), fontSize: 20.0),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFEDEDED),
                  ),
                ),
              ),
            ),
            Divider(
              height: 50.0,
              color: Colors.transparent,
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26.0),
                side: BorderSide(color: Colors.transparent),
              ),
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Куда поедите?",
                  style: TextStyle(
                    color: Color(0xFF6099F7),
                    fontSize: 16.0,
                  ),
                ),
              ),
              color: Color(0xFFE5E5E5),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.location_on, color: Color(0xFF595959), size: 30.0,),
            icon: Icon(Icons.location_on, color: Color(0xFFBDBDBD),),
            title: Text(""),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.settings, color: Color(0xFF595959), size: 30.0,),
            icon: Icon(Icons.settings, color: Color(0xFFBDBDBD),),
            title: Text(""),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.add_circle, color: Color(0xFF595959), size: 30.0,),
            icon: Icon(Icons.add_circle, color: Color(0xFFBDBDBD),),
            title: Text(""),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.star, color: Color(0xFF595959), size: 30.0,),
            icon: Icon(Icons.star, color: Color(0xFFBDBDBD),),
            title: Text(""),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.person, color: Color(0xFF595959), size: 30.0,),
            icon: Icon(Icons.person, color: Color(0xFFBDBDBD),),
            title: Text(""),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
