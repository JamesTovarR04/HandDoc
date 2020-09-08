import 'package:flutter/material.dart';
import 'package:hand_doc/src/pages/login_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    LoginPage().route: (context) => LoginPage(),
  };
}
