import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:hand_doc/src/design/animations.dart';
import 'package:hand_doc/src/pages/signup_page.dart';
import 'package:hand_doc/src/providers/regularExpresions_provider.dart';
import 'package:hand_doc/src/utils/access_util.dart';

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

  RegularExpression regExp = new RegularExpression();

  String message = '';
  bool _checkBoxVal = true;
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
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 10.0),
        _createLoginForm(),
        SizedBox(height: 5.0),
        //----------------------------------------------------------------------
        if (message != '')
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.red,
            ),
          ),
        //----------------------------------------------------------------------
        _savedSessionCheckBox(),
        _createButtonLogin(),
        _createSignupButton(),
        SizedBox(height: 20.0),
      ],
    );
  }

  //------------------------------------------------------------------------------
  Widget _createLoginForm() {
    return Form(
      key: _key,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 2.0),
            TextFormField(
              controller: _controllerEmail,
              style: TextStyle(fontSize: 20.0),
              cursorColor: Theme.of(context).primaryColor,
              validator: (text) {
                if (text.length == 0) {
                  return "Este campo es requerido.";
                } else if (!regExp.email().hasMatch(text) &&
                    !regExp.identification().hasMatch(text)) {
                  return "El formato no es correcto.";
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
                labelText: 'N° identificación o correo',
                counterText: '',
                prefixIcon: Icon(Icons.account_circle,
                    color: Theme.of(context).primaryColor),
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
                } else if (!regExp.password().hasMatch(text)) {
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
          if (_key.currentState.validate()) {
            _key.currentState.save();

            bool access = await AccessUtil.loginUser(
              _controllerEmail.text,
              _controllerPassword.text,
              _checkBoxVal,
            );

            if (!access) {
              setState(() {
                message = "Usuario o contraseña inválidos";
                _controllerPassword.text = "";
              });
            } else {
              Navigator.pushNamed(context, HomePage().route);
            }
          }
        },
      ),
    );
  }

  //------------------------------------------------------------------------------
  Widget _savedSessionCheckBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          activeColor: Theme.of(context).primaryColor,
          onChanged: (bool value) {
            setState(() => this._checkBoxVal = value);
          },
          value: this._checkBoxVal,
        ),
        Text(
          'Guardar en este dispositivo.',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 15.0,
          ),
        ),
      ],
    );
  }

  //------------------------------------------------------------------------------
  Widget _createSignupButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Text(
            "¿No tienes una cuenta?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.black54,
            ),
          ),
        ),
        FlatButton(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(18.0),
            side: BorderSide(color: Theme.of(context).primaryColor),
          ),
          textColor: Theme.of(context).primaryColor,
          child: Text(
            "REGÍSTRATE",
            style: TextStyle(
              fontSize: 13.0,
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(context, SignupPage().route);
          },
        ),
      ],
    );
  }
  //------------------------------------------------------------------------------

}
