import 'package:flutter/material.dart';
import 'package:hand_doc/src/pages/home_page.dart';
import 'package:hand_doc/src/pages/login_page.dart';
import 'package:hand_doc/src/pages/profile_page.dart';
import 'package:hand_doc/src/pages/report_symptoms_page.dart';
import 'package:hand_doc/src/pages/signup_page.dart';
import 'package:hand_doc/src/pages/start_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    LoginPage().route: (context) => LoginPage(),
    SignupPage().route: (context) => SignupPage(),
    StartScreen().route: (context) => StartScreen(),
    ProfilePage().route: (context) => ProfilePage(),
    HomePage().route: (context) => HomePage(),
    ReportSymptomsPage().route: (context) => ReportSymptomsPage(),
  };
}
