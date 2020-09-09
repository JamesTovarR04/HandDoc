import 'package:flutter/material.dart';
import 'package:hand_doc/src/pages/login_page.dart';
import 'package:hand_doc/src/pages/signup_page.dart';
import 'package:hand_doc/src/pages/splashscreen_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    SplashScreen().route: (context) => SplashScreen(),
    LoginPage().route: (context) => LoginPage(),
    SignupPage().route: (context) => SignupPage(),
  };
}
