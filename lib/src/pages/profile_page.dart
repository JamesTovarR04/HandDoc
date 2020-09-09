import 'package:flutter/material.dart';
import 'package:hand_doc/src/classes/user.dart';
import 'package:hand_doc/src/providers/menu_provider.dart';
import 'package:hand_doc/src/providers/regularExpresions_provider.dart';
import 'package:hand_doc/src/utils/DB_util.dart';
import 'package:hand_doc/src/utils/access_util.dart';

class ProfilePage extends StatefulWidget {
  final route = 'profile/';
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _nameUser = "";
  //----------------------------------------------------------------------------
  GlobalKey<FormState> _key = GlobalKey();
  //----------------------------------------------------------------------------
  TextEditingController _controllerName = new TextEditingController();
  TextEditingController _controllerLastName = new TextEditingController();
  TextEditingController _controllerPhone = new TextEditingController();
  TextEditingController _controllerWeight = new TextEditingController();
  TextEditingController _controllerHeight = new TextEditingController();
  //----------------------------------------------------------------------------
  // Object regular expressions
  RegularExpression regExp = new RegularExpression();
  //----------------------------------------------------------------------------
  User _user = new User();
  //----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    Menu menu = new Menu(context);
    return Scaffold(
      drawer: Drawer(child: menu.drawer),
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              child: Text(
                "OS",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(child: _itemsProfile),
    );
  }

  //----------------------------------------------------------------------------
  //Creating separated Widgets
  Widget get _itemsProfile {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(height: 10.0),
        _createAvatarView(),
        _createUpdateUserForm(),
        _createButtonLogin(),
      ],
    );
  }

  //----------------------------------------------------------------------------
  Widget _createUpdateUserForm() {
    return Form(
      key: _key,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
            _createPhoneEdit(),
            //------------------------------------------------------------------
            SizedBox(height: 10.0),
            _createWeightEdit(),
            //------------------------------------------------------------------
            SizedBox(height: 10.0),
            _createHeightEdit(),
          ],
        ),
      ),
    );
  }

  //----------------------------------------------------------------------------
  Widget _createAvatarView() {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100.0,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: Center(
            child: Icon(
              Icons.account_circle,
              color: Colors.white,
              size: 100.0,
            ),
          ),
        ),
      ],
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
  Widget _createWeightEdit() {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      validator: (text) {
        if (text.length == 0) {
          return "Este campo peso es requerido.";
        } else if (!regExp.phone().hasMatch(text)) {
          return "El formato para peso no es correcto.";
        }
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
          Icons.equalizer,
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
        } else if (!regExp.phone().hasMatch(text)) {
          return "El formato para altura no es correcto.";
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
          child: Text("ACTUALIZAR DATOS"),
        ),
        onPressed: () {
          if (_key.currentState.validate()) {
            _key.currentState.save();
            //Here a method is called to login
            _user.name = _controllerName.text;
            _user.lastName = _controllerLastName.text;
            _user.phone = _controllerPhone.text;
            _user.height = double.parse(_controllerHeight.text);
            _user.weight = double.parse(_controllerWeight.text);
            //AccessUtil.loginUser(
            //context, _controllerEmail.text, _controllerPassword.text);
          }
        },
      ),
    );
  }
}
