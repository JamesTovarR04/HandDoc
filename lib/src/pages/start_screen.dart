import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hand_doc/src/pages/home_page.dart';
import 'package:hand_doc/src/pages/login_page.dart';
import 'package:hand_doc/src/pages/welcome_page.dart';
import 'package:hand_doc/src/pages/select_user.dart';
import 'package:hand_doc/src/utils/access_util.dart';
import 'package:flutter/services.dart';

class StartScreen extends StatefulWidget {
  final route = '/';

  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  String route = LoginPage().route;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();

    AccessUtil.checkSession(context).then((value) {
      switch (value) {
        case 0:
          route = HomePage().route;
          break;
        case 1:
          route = SelectUserPage().route;
          break;
        case 2:
          route = LoginPage().route;
          break;
        default:
          route = WelcomePage().route;
      }
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
            radius: 0.9,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'logo',
                child: Image.asset('assets/data/image/icon_white.png',
                    height: 120.0),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "HandDoc",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35.0,
                    fontFamily: 'CaviarDreams',
                    letterSpacing: 3.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Text(
                  'Hospital Municipal De Algeciras',
                  style: TextStyle(
                    color: Color.fromARGB(180, 255, 255, 255),
                    fontSize: 15.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
