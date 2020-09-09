import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hand_doc/src/pages/start_screen.dart';
import 'package:hand_doc/src/routes/routes.dart';
import 'package:hand_doc/src/design/theme_light.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('es', 'ES'),
      ],
      initialRoute: StartScreen().route,
      routes: getApplicationRoutes(),
      theme: themeLight,
      debugShowCheckedModeBanner: false,
      title: 'HandDoc',
    );
  }
}
