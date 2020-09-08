import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingupPage extends StatefulWidget {
  final route = 'singup/';

  @override
  _SingupPageState createState() => new _SingupPageState();
}

class _SingupPageState extends State<SingupPage>
    with SingleTickerProviderStateMixin {
  Animation<double> _sizeAnimation;
  AnimationController _controllerAnimation;
  CurvedAnimation _curve;
//------------------------------------------------------------------------------
//Methods to define initial state of animations
  @override
  void initState() {
    super.initState();
    this._controllerAnimation = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    this._controllerAnimation.addListener(() => setState(() {}));

    this._controllerAnimation.forward();
  }

  @override
  void dispose() {
    super.dispose();

    this._controllerAnimation.dispose();
  }

  //----------------------------------------------------------------------------
  GlobalKey<FormState> _key = GlobalKey();
  //----------------------------------------------------------------------------
  TextEditingController _controllerEmail = new TextEditingController();
  TextEditingController _controllerPass = new TextEditingController();

  TextEditingController _controllerPass2 = new TextEditingController();
  TextEditingController _controllerName = new TextEditingController();
  TextEditingController _controllerLastName = new TextEditingController();
  TextEditingController _controllerPhone = new TextEditingController();

  String _validateChain = '';
  //----------------------------------------------------------------------------
  RegExp emailRegExp =
      new RegExp(r'^\w+[\w-\.]*\@\w+((-\w+)|(\w*))\.[a-z]{2,3}$');
  RegExp contRegExp = new RegExp(r'^([1-zA-Z0-1@.\s]{1,255})$');

  RegExp nameLastNameRegExp = new RegExp(r'^([a-zA-Z ñáéíóú]{2,60})$');

  RegExp phoneRegExp = new RegExp(r'^(\+57)?[ -]*(0|3)?([0-9]){10}$');

  String _name;
  String _lastName;
  String _phone;
  String _email;
  String _password;
  String message = '';

  bool _showPassword = false;
  bool _showPassword2 = false;
  bool _checkBoxVal = false;
  //----------------------------------------------------------------------------
  //Map to save countries
  static const menuItems = <String>['Selecciona País de Origen', 'Colombia'];

  String _btn1SelectedVal = 'Selecciona País de Origen';

  final List<DropdownMenuItem<String>> _dropdownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    this._curve = CurvedAnimation(
        parent: this._controllerAnimation, curve: Curves.bounceInOut);
    this._sizeAnimation =
        Tween<double>(begin: 5, end: 120).animate(this._curve);
    //--------------------------------------------------------------------------
    return Scaffold(
      body: SingleChildScrollView(
        child: _itemsSignUp(),
      ),
    );
  }

//------------------------------------------------------------------------------
//Creating separated Widgets
  Widget _itemsSignUp() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _createUpBoxLogo(),
        SizedBox(height: 25.0),
        _createSignupText(),
        _createSignupForm(),
        _createPrivacyPolicies(),
        _createButtonSignUp(),
        SizedBox(height: 15.0),
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
                child: Image.asset(
                  "assets/data/image/logo.png",
                ),
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
  Widget _createSignupText() {
    return Text(
      "Regístrate",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20.0,
      ),
    );
  }

  //------------------------------------------------------------------------------
  Widget _createSignupForm() {
    return Form(
      key: _key,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 5.0),
            TextFormField(
              textCapitalization: TextCapitalization.words,
              validator: (text) {
                if (text.length == 0) {
                  return "Este campo nombre es requerido.";
                } else if (!nameLastNameRegExp.hasMatch(text)) {
                  return "El formato para nombre no es correcto.";
                }
                return null;
              },
              keyboardType: TextInputType.text,
              controller: _controllerName,
              style: TextStyle(fontSize: 20.0),
              cursorColor: Colors.deepOrange,
              maxLength: 50,
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  borderSide:
                      const BorderSide(color: Colors.deepOrange, width: 1.0),
                ),
                labelStyle: TextStyle(
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35.0)),
                ),
                labelText: "Nombre",
                hintText: "Escribe tu nombre",
                counterText: '',
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Colors.deepOrange,
                ),
              ),
              onSaved: (text) => _name = text,
            ),
            //------------------------------------------------------------
            SizedBox(height: 10.0),
            TextFormField(
              controller: _controllerLastName,
              textCapitalization: TextCapitalization.words,
              validator: (text) {
                if (text.length == 0) {
                  return "Este campo apellido es requerido.";
                } else if (!nameLastNameRegExp.hasMatch(text)) {
                  return "El formato para apellido no es correcto.";
                }
                return null;
              },
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 20.0),
              cursorColor: Colors.deepOrange,
              maxLength: 50,
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  borderSide:
                      const BorderSide(color: Colors.deepOrange, width: 1.0),
                ),
                labelStyle: TextStyle(
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35.0)),
                ),
                labelText: "Apellido",
                hintText: "Escribe tu apellido",
                counterText: '',
                prefixIcon: Icon(
                  Icons.arrow_right,
                  color: Colors.deepOrange,
                ),
              ),
              onSaved: (text) => _lastName = text,
            ),
            //------------------------------------------------------------
            SizedBox(height: 10.0),
            TextFormField(
              textCapitalization: TextCapitalization.words,
              validator: (text) {
                if (text.length == 0) {
                  return "Este campo teléfono es requerido.";
                } else if (!phoneRegExp.hasMatch(text)) {
                  return "El formato para teléfono no es correcto.";
                }
                return null;
              },
              keyboardType: TextInputType.phone,
              controller: _controllerPhone,
              style: TextStyle(fontSize: 20.0),
              cursorColor: Colors.deepOrange,
              maxLength: 50,
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  borderSide:
                      const BorderSide(color: Colors.deepOrange, width: 1.0),
                ),
                labelStyle: TextStyle(
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35.0)),
                ),
                labelText: "Teléfono",
                hintText: "Escribe tu teléfono",
                counterText: '',
                prefixIcon: Icon(
                  Icons.smartphone,
                  color: Colors.deepOrange,
                ),
              ),
              onSaved: (text) => _phone = text,
            ),
            //------------------------------------------------------------
            SizedBox(height: 10.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.0,
                  color: Colors.grey,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.circular(35.0),
              ),
              alignment: Alignment.center,
              width: 100.0,
              height: 65.0,
              child: ListTile(
                title: DropdownButton<String>(
                  isExpanded: true,
                  value: _btn1SelectedVal,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20.0,
                  ),
                  iconEnabledColor: Colors.deepOrange,
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Icon(Icons.arrow_downward),
                  ),
                  iconSize: 24,
                  elevation: 16,
                  onChanged: (String newValue) {
                    setState(() {
                      _btn1SelectedVal = newValue;
                    });
                  },
                  items: this._dropdownMenuItems,
                ),
              ),
            ),
            //------------------------------------------------------------
            SizedBox(height: 10.0),
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
                      const BorderSide(color: Colors.deepOrange, width: 1.0),
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
              onSaved: (text) => _email = text,
            ),
            //------------------------------------------------------------
            SizedBox(height: 10.0),
            TextFormField(
              controller: _controllerPass,
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
                      const BorderSide(color: Colors.deepOrange, width: 1.0),
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
              onSaved: (text) => _password = text,
            ),
            //------------------------------------------------------------
            SizedBox(height: 10.0),
            TextFormField(
              controller: _controllerPass2,
              obscureText: !this._showPassword2,
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
                      const BorderSide(color: Colors.deepOrange, width: 1.0),
                ),
                labelStyle: TextStyle(
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35.0)),
                ),
                labelText: "Confirmar Contraseña",
                hintText: "Contraseña",
                counterText: '',
                prefixIcon: Icon(
                  Icons.redo,
                  color: Colors.deepOrange,
                ),
                suffixIcon: IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color:
                          this._showPassword2 ? Colors.deepOrange : Colors.grey,
                    ),
                    onPressed: () {
                      setState(
                          () => this._showPassword2 = !this._showPassword2);
                    }),
              ),
              onSaved: (text) => _password = text,
            ),
          ],
        ),
      ),
    );
  }

//------------------------------------------------------------------------------
  Widget _createPrivacyPolicies() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 50.0),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Checkbox(
                onChanged: (bool value) {
                  setState(() => this._checkBoxVal = value);
                },
                value: this._checkBoxVal,
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                "He leído y aceptado los",
              ),
              Text(
                "TÉRMINOS Y CONDICIONES",
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Y POLÍTICAS DE PRIVACIDAD",
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

//------------------------------------------------------------------------------
  Widget _createButtonSignUp() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: RaisedButton(
        elevation: 7.0,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.white,
        color: Colors.deepOrange,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(18.0),
        ),
        textColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Text("REGÍSTRATE"),
        ),
        onPressed: (this._checkBoxVal == false) &&
                (_controllerPass2 != _controllerPass)
            ? null
            : () {
                if (_key.currentState.validate()) {
                  _key.currentState.save();
                  message = 'Gracias \n $_email \n $_password';
                }
              },
      ),
    );
  }
}
