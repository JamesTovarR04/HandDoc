import 'package:flutter/material.dart';
import 'package:hand_doc/src/pages/login_page.dart';
import 'package:hand_doc/src/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginPage().route,
      routes: getApplicationRoutes(),
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      title: 'HandDoc',
    );
  }
}
