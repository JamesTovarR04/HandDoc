import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:hand_doc/src/pages/login_page.dart';
import 'package:hand_doc/src/pages/signup_page.dart';

class WelcomePage extends StatefulWidget {
  final route = '/welcome';

  @override
  State<StatefulWidget> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 4), vsync: this);
    animation = Tween<double>(begin: 0.9, end: 1.2).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).accentColor
            ],
            radius: animation.value,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'logo',
              child: Image.asset('assets/data/image/icon_white.png',
                  height: 100.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Bienvenido',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 24.0),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 7.0),
              child: Text(
                '¿Es tu primera vez por aquí?',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green[50]),
              ),
            ),
            _buttonSignUp(context),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 7.0),
              child: Text(
                '¿Ya tienes una cuenta?',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green[50]),
              ),
            ),
            _buttonLogin(context),
          ],
        ),
      ),
    );
  }

  Widget _buttonSignUp(BuildContext context) {
    return RaisedButton(
      color: Colors.white,
      elevation: 7.0,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(18.0),
      ),
      textColor: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Text(
          "REGÍSTRATE",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onPressed: () {
        Navigator.pushNamed(context, SignupPage().route);
      },
    );
  }

  Widget _buttonLogin(BuildContext context) {
    return FlatButton(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(18.0),
        side: BorderSide(color: Colors.white),
      ),
      textColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Text("Iniciar Sesión"),
      ),
      onPressed: () {
        Navigator.pushNamed(context, LoginPage().route);
      },
    );
  }
}
