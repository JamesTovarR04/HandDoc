import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:hand_doc/src/pages/login_page.dart';

class StartScreen extends StatefulWidget {
  final route = '/';

  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();

    /*Timer(Duration(seconds: 3), () {
      Navigator.pushNamed(context, LoginPage().route);
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [Colors.white, Colors.lightGreen],
          radius: 1.0,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/data/image/logo.png', height: 200.0),
            Text(
              'Ejemplo',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
