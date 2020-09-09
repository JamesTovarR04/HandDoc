import 'dart:async';
import 'package:flutter/material.dart';

import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  final route = '/';
  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }
}

class SplashState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = new Duration(seconds: 1);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushNamed(context, LoginPage().route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Column(
                children: [
                  Image.asset(
                    'assets/data/image/logo.png',
                    height: 300.0,
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    "HandDoc",
                    style: TextStyle(
                        color: Colors.green[700],
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ), /*
            # Para indicar progreso
            Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 1,
            ),*/
          ],
        ),
      ),
    );
  }
}
