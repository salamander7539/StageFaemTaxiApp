import 'package:flutter/material.dart';

import 'jsons/get_order.dart';
import 'addresses_screen.dart';
import 'main.dart';

import 'jsons/cancel_order.dart';



class AwaitTaxi extends StatefulWidget {
  @override
  _TaxiState createState() => _TaxiState();
}

class _TaxiState extends State<AwaitTaxi> {
  Path path;
  var cancelCodeOrder;
  var awaitButton = "Да";
  var newOrderState;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

    @override
  Widget build(BuildContext context) {
    RouteSettings routeSettings = ModalRoute.of(context).settings;
    path = routeSettings.arguments;
    return new Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.blueGrey,
                  ),
                  padding: EdgeInsets.all(8.0),
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Center(
                    child: new ListTile(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      leading: Icon(
                        Icons.access_time,
                        size: 50,
                      ),
                      title: new Text(
                        orderState,
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      subtitle: Text(
                        "\n$addUnrestricted_value\n~~~~~~~~~~~~~~~~\n$destUnrestricted_value\nСтоимость: $priceData $currencyData.",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 20.0,
            color: Colors.white,
          ),
          Text(
            "Хотите отменить заказ?",
            style: TextStyle(color: Colors.grey.shade800, fontSize: 20.0),
          ),
          Divider(
            height: 20.0,
            color: Colors.white,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                onPressed: () async {
                  cancelCodeOrder = await cancelOrder();
                  setState(() {
                    if (cancelCodeOrder == 200) {
                      awaitButton = "Заказ отменен";
                    }
                  });
                },

                textColor: Colors.white,
                color: Colors.blueGrey,
                padding: const EdgeInsets.all(0.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Colors.blueGrey),
                ),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    awaitButton,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}