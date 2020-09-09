import 'package:flutter/material.dart';
import 'package:hand_doc/src/pages/login_page.dart';
import 'package:hand_doc/src/pages/signup_page.dart';
import 'package:hand_doc/src/pages/start_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    LoginPage().route: (context) => LoginPage(),
    SignupPage().route: (context) => SignupPage(),
    StartScreen().route: (context) => StartScreen()
  };
}
