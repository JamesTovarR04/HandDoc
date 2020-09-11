import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:hand_doc/src/design/animations.dart';
import 'package:hand_doc/src/pages/profile_page.dart';
import 'package:hand_doc/src/pages/signup_page.dart';
import 'package:hand_doc/src/utils/access_util.dart';
import 'package:hand_doc/src/pages/triage_page.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  final route = 'login/';

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  Animation<double> _sizeAnimation;
  AnimationController _controllerAnimation;
  CurvedAnimation _curve;
  //----------------------------------------------------------------------------
  GlobalKey<FormState> _key = GlobalKey();
  //----------------------------------------------------------------------------
  TextEditingController _controllerEmail = new TextEditingController();
  TextEditingController _controllerPassword = new TextEditingController();
  //----------------------------------------------------------------------------

  RegExp emailRegExp =
      new RegExp(r'^\w+[\w-\.]*\@\w+((-\w+)|(\w*))\.[a-z]{2,3}$');

  RegExp contRegExp = new RegExp(r'^([1-zA-Z0-1@.\s]{1,255})$');

  String message = '';
//------------------------------------------------------------------------------
//Methods to define initial state of animations
  @override
  void initState() {
    super.initState();
    //--------------------------------------------------------------------------
    this._controllerAnimation = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    this._controllerAnimation.addListener(() => setState(() {}));

    this._controllerAnimation.forward();
    //--------------------------------------------------------------------------
  }

  @override
  void dispose() {
    super.dispose();
    this._controllerAnimation.dispose();
  }

  //----------------------------------------------------------------------------
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    this._curve = CurvedAnimation(
        parent: this._controllerAnimation, curve: Curves.bounceInOut);
    this._sizeAnimation =
        Tween<double>(begin: 5, end: 120).animate(this._curve);
    //--------------------------------------------------------------------------
    return Scaffold(
      body: SingleChildScrollView(
        child: _itemsLogin(),
      ),
    );
  }

  //------------------------------------------------------------------------------
  //Creating separated Widgets
  Widget _itemsLogin() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        AnimationH.createUpBoxLogo(context, _sizeAnimation.value),
        SizedBox(height: 20.0),
        Text(
          "Inicia sesión",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22.0,
          ),
        ),
        SizedBox(height: 5.0),
        _createLoginForm(),
        //----------------------------------------------------------------------
        Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.red,
          ),
        ),
        SizedBox(height: 4.0),
        //----------------------------------------------------------------------
        _createButtonLogin(),
        _createForgotPass(),
        _createSignupButton(),
      ],
    );
  }

  //------------------------------------------------------------------------------
  Widget _createLoginForm() {
    return Form(
      key: _key,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 2.0),
            TextFormField(
              controller: _controllerEmail,
              style: TextStyle(fontSize: 20.0),
              cursorColor: Theme.of(context).primaryColor,
              validator: (text) {
                if (text.length == 0) {
                  return "Este campo correo es requerido.";
                } else if (!emailRegExp.hasMatch(text)) {
                  return "El formato para correo no es correcto.";
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              maxLength: 50,
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  borderSide: const BorderSide(color: Colors.green, width: 1),
                ),
                labelStyle: TextStyle(
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35.0)),
                ),
                hintText: 'Ingresa tu correo',
                labelText: 'Correo',
                counterText: '',
                prefixIcon:
                    Icon(Icons.email, color: Theme.of(context).primaryColor),
              ),
            ),
            //------------------------------------------------------------------
            SizedBox(height: 6.0),
            TextFormField(
              controller: _controllerPassword,
              obscureText: !this._showPassword,
              style: TextStyle(fontSize: 20.0),
              cursorColor: Theme.of(context).primaryColor,
              validator: (text) {
                if (text.length == 0) {
                  return "Este campo contraseña es requerido.";
                } else if (text.length <= 5) {
                  return "Tu contraseña debe ser al menos de 5 caracteres.";
                } else if (!contRegExp.hasMatch(text)) {
                  return "El formato para contraseña no es correcto.";
                }
                return null;
              },
              keyboardType: TextInputType.text,
              maxLength: 20,
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  borderSide: const BorderSide(color: Colors.green, width: 1),
                ),
                labelStyle: TextStyle(
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35.0)),
                ),
                hintText: 'Ingresa tu contraseña',
                labelText: 'Contraseña',
                counterText: '',
                prefixIcon: Icon(
                  Icons.vpn_key,
                  color: Theme.of(context).primaryColor,
                ),
                suffixIcon: IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: this._showPassword
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() => this._showPassword = !this._showPassword);
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //------------------------------------------------------------------------------
  Widget _createButtonLogin() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        elevation: 7.0,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(18.0),
        ),
        textColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Text("INICIAR SESIÓN"),
        ),
        onPressed: () async {
          FocusScope.of(context).requestFocus(new FocusNode());
          int value = 0;
          if (_key.currentState.validate()) {
            _key.currentState.save();
            //Here a method is called to login

            value = await AccessUtil.loginUser(
                _controllerEmail.text, _controllerPassword.text);

            if (value == 0) {
              setState(() {
                message = "Usuario o contraseña inválidos";
                _controllerPassword.text = "";
              });
            } else if (value == 1) {
              Navigator.pushNamed(context, HomePage().route);
            }
          }
        },
      ),
    );
  }

  //------------------------------------------------------------------------------
  Widget _createForgotPass() {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 9.0,
        ),
        child: Text(
          "¿Olvidaste tu contraseña?",
          style: TextStyle(fontSize: 15.0, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, ProfilePage().route);
      },
    );
  }

  Widget _createSignupButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Text(
            "¿No tienes una cuenta?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.0,
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
        InkWell(
          child: Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 20.0),
            child: Text(
              "REGÍSTRATE",
              textAlign: TextAlign.center,
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, SignupPage().route);
          },
        ),
        InkWell(
          child: Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
            child: Text(
              "TRIAGE",
              textAlign: TextAlign.center,
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, TriagePage().route);
          },
        ),
      ],
    );
  }
//------------------------------------------------------------------------------

}
