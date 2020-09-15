import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:hand_doc/src/pages/login_page.dart';
import 'package:hand_doc/src/pages/signup_page.dart';
import 'package:hand_doc/src/utils/DB_util.dart';
import 'package:hand_doc/src/utils/access_util.dart';
import 'package:hand_doc/src/pages/home_page.dart';

class SelectUserPage extends StatefulWidget {
  final route = '/selectUser';

  @override
  _SelectUserPageState createState() => _SelectUserPageState();
}

class _SelectUserPageState extends State<SelectUserPage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  List<Widget> _listButtonUsers;

  @override
  void initState() {
    super.initState();
    _listButtonUsers = [];
    controller =
        AnimationController(duration: const Duration(seconds: 4), vsync: this);
    animation = Tween<double>(begin: 0.9, end: 1.2).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    DBUtil.usersSaved().then((users) {
      if (users != null) {
        _listButtonUsers = users.map((user) {
          String name = user['name'] + ' ' + user['lastName'];
          return _buttonUser(name, user['id']);
        }).toList();
        setState(() {});
      }
    });
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 30.0),
              Hero(
                tag: 'logo',
                child: Image.asset('assets/data/image/icon_white.png',
                    height: 90.0),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "HandDoc",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontFamily: 'CaviarDreams',
                    letterSpacing: 3.0,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'Sesiones guardadas',
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Divider(
                  color: Colors.green[50],
                  height: 15,
                  thickness: 0.5,
                ),
              ),
              ..._listButtonUsers,
              Divider(
                color: Colors.green[50],
                height: 9.0,
                thickness: 0.5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 7.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: _buttonSignUp(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: _buttonLogin(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonSignUp() {
    return FlatButton(
      color: Colors.white,
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

  Widget _buttonLogin() {
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

  Widget _buttonUser(String name, int idUser) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: InkWell(
        child: SizedBox(
          width: 100,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 8.0,
            ),
            decoration: BoxDecoration(
              //border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
            ),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 9.0),
                  child: Icon(
                    Icons.account_circle,
                    color: Theme.of(context).primaryColor,
                    size: 28.0,
                  ),
                ),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () async {
          await AccessUtil.loginSavedUser(idUser);
          Navigator.pushNamed(context, HomePage().route);
        },
      ),
    );
  }
}
