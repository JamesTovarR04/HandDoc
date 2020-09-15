import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hand_doc/src/design/animations.dart';
import 'package:hand_doc/src/classes/user.dart';
import 'package:hand_doc/src/pages/home_page.dart';
import 'package:hand_doc/src/providers/regularExpresions_provider.dart';
import 'package:hand_doc/src/utils/access_util.dart';

class SignupPage extends StatefulWidget {
  final route = 'signup/';

  @override
  _SignupPageState createState() => new _SignupPageState();
}

class _SignupPageState extends State<SignupPage>
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

  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerLastName = TextEditingController();
  TextEditingController _controllerPersonalIdentification =
      TextEditingController();
  TextEditingController _controllerPhone = TextEditingController();
  TextEditingController _controllerBirthday = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerWeight = TextEditingController();
  TextEditingController _controllerHeight = TextEditingController();
  TextEditingController _controllerPass = TextEditingController();
  TextEditingController _controllerPass2 = TextEditingController();
  //----------------------------------------------------------------------------
  // Object regular expressions
  RegularExpression regExp = new RegularExpression();

  User _user = new User();
  //----------------------------------------------------------------------------
  String message = '';

  bool _showPassword = false;
  bool _showPassword2 = false;
  bool _checkBoxVal = false;
  bool _checkBoxSave = false;

  String _genreSelected = 'Sexo';
  static const genres = <String>[
    'Sexo',
    'Masculino',
    'Femenino',
  ];

  final List<DropdownMenuItem<String>> _dropdownMenuItems = genres
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();
  //----------------------------------------------------------------------------
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
        AnimationH.createUpBoxLogo(context, _sizeAnimation.value),
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
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 5.0),
            _createNameEdit(),
            //------------------------------------------------------------------
            SizedBox(height: 10.0),
            _createLastNameEdit(),
            //------------------------------------------------------------------
            SizedBox(height: 10.0),
            _createPersonalIdentificationEdit(),
            //------------------------------------------------------------------
            SizedBox(height: 10.0),
            _createSelectGenre(),
            //------------------------------------------------------------------
            SizedBox(height: 10.0),
            _createPhoneEdit(),
            //------------------------------------------------------------------
            SizedBox(height: 10.0),
            _createDateEdit(context),
            //------------------------------------------------------------------
            SizedBox(height: 10.0),
            _createWeightEdit(),
            //------------------------------------------------------------------
            SizedBox(height: 10.0),
            _createHeightEdit(),
            //------------------------------------------------------------------
            SizedBox(height: 10.0),
            _createEmailEdit(),
            //------------------------------------------------------------------
            SizedBox(height: 10.0),
            _createPassEdit(),
            //------------------------------------------------------------------
            SizedBox(height: 10.0),
            _createPass2Edit(),
            _savedSessionCheckBox(),
          ],
        ),
      ),
    );
  }

  //------------------------------------------------------------------------------
  Widget _createDateEdit(BuildContext context) {
    return TextFormField(
      enableInteractiveSelection: false,
      controller: _controllerBirthday,
      style: TextStyle(fontSize: 20.0),
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
          borderSide: const BorderSide(color: Colors.green, width: 1.0),
        ),
        prefixIcon: Icon(
          Icons.cake,
          color: Theme.of(context).primaryColor,
        ),
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
        ),
        hintText: "Fecha de nacimiento",
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    );
  }

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      locale: Locale('es', 'ES'),
      initialDate: DateTime.now(),
      firstDate: DateTime(1920),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        _user.birthday = "${picked.year}/${picked.month}/${picked.day}";
        _controllerBirthday.text = _user.birthday;
      });
    }
  }

  //------------------------------------------------------------------------------
  Widget _createPrivacyPolicies() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
                "TÉRMINOS, CONDICIONES",
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

  //----------------------------------------------------------------------------
  Widget _createButtonSignUp() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: RaisedButton(
        elevation: 7.0,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.white,
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(18.0),
        ),
        textColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Text("REGÍSTRATE"),
        ),
        onPressed: ((this._checkBoxVal == false) &&
                (_controllerPass2 != _controllerPass))
            ? null
            : () async {
                if (_key.currentState.validate()) {
                  _key.currentState.save();

                  FocusScope.of(context).requestFocus(new FocusNode());
                  _user.name = _controllerName.text;
                  _user.lastName = _controllerLastName.text;
                  _user.phone = _controllerPhone.text;
                  _user.personalIdentification =
                      int.parse(_controllerPersonalIdentification.text);
                  _user.email = _controllerEmail.text;
                  _user.genre = _genreSelected;
                  _user.password = _controllerPass.text;
                  _user.birthday = _controllerBirthday.text;
                  _user.height = double.parse(_controllerHeight.text);
                  _user.weight = double.parse(_controllerWeight.text);
                  _user.save = (_checkBoxSave) ? 1 : 0;

                  //------------------------------------------------------------
                  if (await AccessUtil.checkIfRegistered(
                    _controllerPersonalIdentification.text,
                    _controllerEmail.text,
                  )) {
                    setState(() {
                      message = "El usuario se encuentra registrado";
                    });
                  } else {
                    if (await AccessUtil.registerUser(_user)) {
                      Navigator.pushNamed(context, HomePage().route);
                    } else {
                      setState(() {
                        message = "Algo salió mal :(";
                      });
                    }
                  }
                  //------------------------------------------------------------
                }
              },
      ),
    );
  }

//----------------------------------------------------------------------------
  Widget _createNameEdit() {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      validator: (text) {
        if (text.length == 0) {
          return "Este campo nombre es requerido.";
        } else if (!regExp.name().hasMatch(text)) {
          return "El formato para nombre no es correcto.";
        }
        return null;
      },
      keyboardType: TextInputType.text,
      controller: _controllerName,
      style: TextStyle(fontSize: 20.0),
      cursorColor: Theme.of(context).primaryColor,
      maxLength: 50,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
          borderSide: const BorderSide(color: Colors.green, width: 1.0),
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
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  //----------------------------------------------------------------------------
  Widget _createLastNameEdit() {
    return TextFormField(
      controller: _controllerLastName,
      textCapitalization: TextCapitalization.words,
      validator: (text) {
        if (text.length == 0) {
          return "Este campo apellido es requerido.";
        } else if (!regExp.name().hasMatch(text)) {
          return "El formato para apellido no es correcto.";
        }
        return null;
      },
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20.0),
      cursorColor: Theme.of(context).primaryColor,
      maxLength: 50,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
          borderSide: const BorderSide(color: Colors.green, width: 1.0),
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
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  //----------------------------------------------------------------------------
  Widget _createPhoneEdit() {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      validator: (text) {
        if (text.length == 0) {
          return "Este campo teléfono es requerido.";
        } else if (!regExp.phone().hasMatch(text)) {
          return "El formato para teléfono no es correcto.";
        }
        return null;
      },
      keyboardType: TextInputType.phone,
      controller: _controllerPhone,
      style: TextStyle(fontSize: 20.0),
      cursorColor: Theme.of(context).primaryColor,
      maxLength: 50,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
          borderSide: const BorderSide(color: Colors.green, width: 1.0),
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
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  //----------------------------------------------------------------------------

  Widget _createSelectGenre() {
    return DropdownButtonFormField<String>(
      validator: (value) {
        return (value.toString() == 'Sexo') ? 'Seleccione el sexo' : null;
      },
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
          borderSide: const BorderSide(color: Colors.green, width: 1.0),
        ),
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
        ),
        labelText: "Sexo",
        hintText: "Sexo",
        prefixIcon: Icon(
          Icons.wc,
          color: Theme.of(context).primaryColor,
        ),
      ),
      isExpanded: true,
      value: _genreSelected,
      style: TextStyle(
        color: Colors.grey,
        fontSize: 20.0,
      ),
      iconEnabledColor: Theme.of(context).primaryColor,
      icon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Icon(Icons.arrow_downward),
      ),
      iconSize: 24,
      elevation: 16,
      onChanged: (String newValue) {
        setState(() {
          _genreSelected = newValue;
        });
      },
      items: this._dropdownMenuItems,
    );
  }

  //----------------------------------------------------------------------------
  Widget _createWeightEdit() {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      validator: (text) {
        if (text.length == 0) {
          return "Este campo peso es requerido.";
        } else if (!(double.parse(text) > 0 && double.parse(text) < 500)) {
          return "El valor del peso es incorrecto.";
        }
        /*else if (!regExp.weight().hasMatch(text)) {
          return "El formato para peso no es correcto.";
        }*/
        return null;
      },
      keyboardType: TextInputType.phone,
      controller: _controllerWeight,
      style: TextStyle(fontSize: 20.0),
      cursorColor: Theme.of(context).primaryColor,
      maxLength: 50,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
          borderSide: const BorderSide(color: Colors.green, width: 1.0),
        ),
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
        ),
        labelText: "Peso",
        hintText: "Escribe tu peso (Kg)",
        counterText: '',
        prefixIcon: Icon(
          Icons.settings_input_svideo,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  //----------------------------------------------------------------------------
  Widget _createHeightEdit() {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      validator: (text) {
        if (text.length == 0) {
          return "Este campo altura es requerido.";
        } /*else if (!regExp.phone().hasMatch(text)) {
          return "El formato para altura no es correcto.";
        }*/
        else if (!(double.parse(text) > 0.30 && double.parse(text) < 2.20)) {
          return "El valor de la altura es incorrecto.";
        }
        return null;
      },
      keyboardType: TextInputType.phone,
      controller: _controllerHeight,
      style: TextStyle(fontSize: 20.0),
      cursorColor: Theme.of(context).primaryColor,
      maxLength: 50,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
          borderSide: const BorderSide(color: Colors.green, width: 1.0),
        ),
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
        ),
        labelText: "Altura",
        hintText: "Escribe tu altura (m)",
        counterText: '',
        prefixIcon: Icon(
          Icons.equalizer,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  //----------------------------------------------------------------------------
  Widget _createPersonalIdentificationEdit() {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      validator: (text) {
        if (text.length == 0) {
          return "Este campo N° identificación es requerido.";
        } else if (!regExp.identification().hasMatch(text)) {
          return "El formato para N° identificación no es correcto.";
        }
        return null;
      },
      keyboardType: TextInputType.phone,
      controller: _controllerPersonalIdentification,
      style: TextStyle(fontSize: 20.0),
      cursorColor: Theme.of(context).primaryColor,
      maxLength: 50,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
          borderSide: const BorderSide(color: Colors.green, width: 1.0),
        ),
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
        ),
        labelText: "N° Identificación",
        hintText: "Escribe tu N° Identificación",
        counterText: '',
        prefixIcon: Icon(
          Icons.camera_front,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  //----------------------------------------------------------------------------
  Widget _createEmailEdit() {
    return TextFormField(
      controller: _controllerEmail,
      style: TextStyle(fontSize: 20.0),
      cursorColor: Theme.of(context).primaryColor,
      validator: (text) {
        if (text.length == 0) {
          return "Este campo correo es requerido.";
        } else if (!regExp.email().hasMatch(text)) {
          return "El formato para correo no es correcto.";
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      maxLength: 50,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
          borderSide: const BorderSide(color: Colors.green, width: 1.0),
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
        prefixIcon: Icon(
          Icons.email,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  //----------------------------------------------------------------------------
  Widget _createPassEdit() {
    return TextFormField(
      controller: _controllerPass,
      obscureText: !this._showPassword,
      style: TextStyle(fontSize: 20.0),
      cursorColor: Colors.deepOrange,
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
          borderSide: const BorderSide(color: Colors.green, width: 1.0),
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
        prefixIcon: Icon(Icons.vpn_key, color: Theme.of(context).primaryColor),
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
    );
  }

  //----------------------------------------------------------------------------
  Widget _savedSessionCheckBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          activeColor: Theme.of(context).primaryColor,
          onChanged: (bool value) {
            setState(() => this._checkBoxSave = value);
          },
          value: this._checkBoxSave,
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

  //----------------------------------------------------------------------------
  Widget _createPass2Edit() {
    return TextFormField(
      controller: _controllerPass2,
      obscureText: !this._showPassword2,
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
          borderSide: const BorderSide(color: Colors.green, width: 1.0),
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
          color: Theme.of(context).primaryColor,
        ),
        suffixIcon: IconButton(
            icon: Icon(
              Icons.remove_red_eye,
              color: this._showPassword2
                  ? Theme.of(context).primaryColor
                  : Colors.grey,
            ),
            onPressed: () {
              setState(() => this._showPassword2 = !this._showPassword2);
            }),
      ),
    );
  }
}
