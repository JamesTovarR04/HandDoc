import 'package:flutter/material.dart';
import 'package:hand_doc/src/classes/user.dart';
import 'package:hand_doc/src/providers/menu_provider.dart';
import 'package:hand_doc/src/utils/DB_util.dart';

class MedicinePage extends StatefulWidget {
  final route = 'medicine/';
  MedicinePage({Key key}) : super(key: key);

  @override
  _MedicinePageState createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> {
  String _nameUser;
  List<String> _nameDisease = new List<String>(4);
  Map<int, List<String>> _medicine = new Map<int, List<String>>();
  //----------------------------------------------------------------------------
  User _user = new User();
//----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _user.disease = 0;

    DBUtil.readUser().then((user) {
      if (user != null)
        setState(() {
          _user = user;
          _nameUser = _user.name[0] + _user.lastName[0];
        });
    });
    //--------------------------------------------------------------------------
    setState(() {
      _nameDisease = [
        "Nada",
        "Neumonía",
        "Gastrointeritis",
        "Dengue",
        "Bronquitis aguda",
      ];
      //--------------------------------------------------------------------------
      _medicine = {
        0: [
          "",
        ],
        1: [
          "Ampicilina sulbactam 1.5gr c/6h",
          "Claritromicina 500mg iv c/12h",
        ],
        2: [
          "Lactato ringer 1000 en bolo luego 500 cc c 8 horas",
          "(Definir si es bacteriana e iniciar antibiótico: ciprofloxacina amp de 100mg 4 fcos iv c 12 horas 9",
          "Acetaminofén 500mg vo c 6 horas",
          "Hioscina c/ 8 horas",
          "Omeprazol 40 mg iv c /24 horas",
          "Metroclopramida 10 mg 1amp iv",
        ],
        3: [
          "Lev  ssn 0.9 % 1500 cc cada 12 horas. Dependiendo de clasificación asi mismo se da manejo con líquidos endovenosos",
        ],
        4: [
          "Loratadina tab 10 mg cada 24 horas",
          "Salbutamol 2 puff cada 6 horas",
          "Bromuro de ipratropio 2puf cada 12 horas",
          "Oxigeno por cánula nasal (1-2-3 litros..)",
          "Definir manejo antibiótico en caso de requerirlo : Ampicilina sulbactam",
          "Claritromicina",
        ],
      };
    });
  }

  //----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: Menu()),
      appBar: AppBar(
        title: Text("Medicina"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              child: Text(
                _nameUser != null ? _nameUser : "",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(child: _itemsMedicine()),
    );
  }

  //----------------------------------------------------------------------------
  //Creating separated Widgets
  Widget _itemsMedicine() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(height: 20.0),
        _user.disease == 0 ? _createHealthy() : _createMedicalIf(),
        SizedBox(height: 20.0),
        Image.asset(
          'assets/data/image/icon_green.png',
          height: 150.0,
        ),
        Padding(
          padding: EdgeInsets.only(top: 5.0),
          child: Text(
            'Hospital Municipal De Algeciras',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 40.0),
      ],
    );
  }

  //----------------------------------------------------------------------------
  Widget _createHealthy() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            elevation: 10.0,
            child: Column(
              children: <Widget>[
                Image.asset('assets/data/image/healthy.jpg'),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "En el momento no has reportado síntomas, tu estado es saludable.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  //----------------------------------------------------------------------------

  Widget _createMedicalIf() {
    return Column(
      children: [
        Text(
          "Nuestro diagnóstico corresponde a:",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.0),
        _createCard(),
        SizedBox(height: 10.0),
      ],
    );
  }

  //----------------------------------------------------------------------------
  Widget _createCard() {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 5.0,
      child: Column(
        children: <Widget>[
          Stack(
            children: [
              Image.asset('assets/data/image/diagnostic.jpg'),
              Padding(
                padding: const EdgeInsets.only(
                  top: 75.0,
                  left: 50.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  width: 250.0,
                  height: 70.0,
                  child: Center(
                    child: Text(
                      //--------------------------------------------------------
                      // Define name Disease
                      _user.disease != 0 ? _nameDisease[_user.disease] : "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(),
          Text(
            "Te recomendamos " +
                _medicine[_user.disease].length.toString() +
                " medicamentos:",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            height: 280.0,
            padding: EdgeInsets.all(10.0),
            child: ListView.builder(
              itemCount: _medicine[_user.disease].length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.forward,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(_medicine[_user.disease][index] != null
                          ? _medicine[_user.disease][index] + "."
                          : ""),
                    ),
                    Divider(
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                );
              },
            ),
          ),
          Icon(
            Icons.arrow_drop_down_circle,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
