import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:hand_doc/src/pages/signup_page.dart';
import 'package:hand_doc/src/utils/access_util.dart';

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
        _createUpBoxLogo(),
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
        SizedBox(height: 8.0),
        Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.red,
          ),
        ),
        //----------------------------------------------------------------------
        _createButtonLogin(),
        _createForgotPass(),
        _createSignupButton(),
      ],
    );
  }

  //------------------------------------------------------------------------------
  Widget _createUpBoxLogo() {
    return Container(
      width: 550.0,
      height: 300.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.deepOrange, Colors.orange, Colors.deepOrange],
            stops: [0.3, 1, 0.5],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(200.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: this._sizeAnimation.value,
              height: this._sizeAnimation.value,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(70.0)),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset("assets/data/image/logo.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "HandDoc",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 17.0),
              ),
            )
          ],
        ),
      ),
    );
  }

  //------------------------------------------------------------------------------
  Widget _createLoginForm() {
    return Form(
      key: _key,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 5.0),
            TextFormField(
              controller: _controllerEmail,
              style: TextStyle(fontSize: 20.0),
              cursorColor: Colors.deepOrange,
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
                  borderSide:
                      const BorderSide(color: Colors.deepOrange, width: 1),
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
                prefixIcon: Icon(Icons.email, color: Colors.deepOrange),
              ),
            ),
            //------------------------------------------------------------------
            SizedBox(height: 5.0),
            TextFormField(
              controller: _controllerPassword,
              obscureText: !this._showPassword,
              style: TextStyle(fontSize: 20.0),
              cursorColor: Colors.deepOrange,
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
                  borderSide:
                      const BorderSide(color: Colors.deepOrange, width: 1),
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
                prefixIcon: Icon(Icons.vpn_key, color: Colors.deepOrange),
                suffixIcon: IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color:
                          this._showPassword ? Colors.deepOrange : Colors.grey,
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
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
      child: RaisedButton(
        color: Colors.deepOrange,
        elevation: 7.0,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.deepOrange),
        ),
        textColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Text("INICIA SESIÓN"),
        ),
        onPressed: () {
          if (_key.currentState.validate()) {
            _key.currentState.save();
            //Here a method is called to login
            AccessUtil.loginUser(
                context, _controllerEmail.text, _controllerPassword.text);
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
          vertical: 12.0,
        ),
        child: Text(
          "¿Olvidaste tu contraseña?",
          style: TextStyle(fontSize: 15.0, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ),
      onTap: () {
        //Navigator.pushNamed(context, ForgotpassPage().route);
      },
    );
  }

  Widget _createSignupButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 30.0),
          child: Text(
            "¿No tienes una cuenta?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.deepOrange,
            ),
          ),
        ),
        InkWell(
          child: Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
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
      ],
    );
  }
//------------------------------------------------------------------------------

}
