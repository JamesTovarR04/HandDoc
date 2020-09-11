import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hand_doc/src/pages/home_page.dart';
import 'package:hand_doc/src/pages/login_page.dart';
import 'package:hand_doc/src/utils/access_util.dart';

class StartScreen extends StatefulWidget {
  final route = '/';

  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  String route = LoginPage().route;

  @override
  void initState() {
    super.initState();

    // Verify if session was started before and create a Database
    AccessUtil.checkSession(context).then((value) {
      if (value == 0)
        route = LoginPage().route;
      else
        route = HomePage().route;
    });
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).accentColor
            ],
            radius: 1.0,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/data/image/icon_white.png', height: 150.0),
              SizedBox(height: 30.0),
              Text(
                'HandDoc',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  //fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
