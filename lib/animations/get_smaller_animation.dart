import 'package:flutter/material.dart';

class GetPageSmall extends PageRouteBuilder {
  final Widget widget;

  GetPageSmall({this.widget})
      : super(
            transitionDuration: Duration(seconds: 2),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secAnimation,
                Widget child) {
              animation = Tween(begin: 0.9, end: 1.0).animate(CurvedAnimation(
                  parent: animation, curve: Curves.decelerate));
              return ScaleTransition(
                alignment: Alignment.center,
                scale: animation,
                child: child,
              );
            },
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secAnimation) {
              return widget;
            });
}
