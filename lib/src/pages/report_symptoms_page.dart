import 'package:flutter/material.dart';
import 'package:hand_doc/src/classes/user.dart';
import 'package:hand_doc/src/providers/custom_dialog.dart';
import 'package:hand_doc/src/providers/menu_provider.dart';
import 'package:hand_doc/src/utils/DB_util.dart';

class ReportSymptomsPage extends StatefulWidget {
  final route = 'report/';
  ReportSymptomsPage({Key key}) : super(key: key);

  @override
  _ReportSymptomsPageState createState() => _ReportSymptomsPageState();
}

class _ReportSymptomsPageState extends State<ReportSymptomsPage> {
  List<bool> _checkbox = new List<bool>(16);
  List<String> symptoms = new List<String>(16);
  //----------------------------------------------------------------------------
  User _user = new User();
  //----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    // Initializing values for list checkbox bool validation

    setState(() {
      for (var i = 0; i < _checkbox.length; i++) {
        _checkbox[i] = false;
      }

      symptoms = [
        "Dolor agudo en el pecho",
        "Dificultad para respirar",
        "Respiración rápida",
        "Sibilancias al respirar",
        //------------------
        "Escalofríos",
        "Dolor de abdomen",
        "Cólicos",
        "Diarrea",
        //------------------
        "Dolor en las articulaciones",
        "Dolor en la parte posterior de los ojos",
        "Erupciones o manchas rojas",
        "Facilidad para desarrollar hematomas",
        //------------------
        "Tos con flema, seca o crónica",
        "Congestión nasal",
        "Dificultad para respirar",
        "Dolor de garganta",
      ];
      //------------------------------------------------------------------------
      DBUtil.readUser().then((user) {
        if (user.length > 0)
          setState(() {
            _user = user[0];
          });
      });
    });
  }

  //----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // Delete this code
    Menu menu = new Menu(context);
    return Scaffold(
      drawer: Drawer(
        child: menu.drawer,
      ),
      appBar: AppBar(
        title: Text("Síntomas"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _itemsSymptoms(),
            Container(
              height: MediaQuery.of(context).size.height / 1.55,
              padding: EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: symptoms.length,
                itemBuilder: (context, index) {
                  return _listSymptomTile(symptoms[index], index);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () async {
          // Update atribute disease
          setState(() {
            _user.disease = _determineDisease() + 1;
          });

          try {
            if (await DBUtil.updateUser(_user) == 1) {
              showDialog(
                context: context,
                builder: (BuildContext context) => CustomDialog(
                  title: '¡Recibido el reporte!',
                  description:
                      "Se ha recibido tu diagnóstico, de inmediato te vamos a redirijir a la pantalla donde podrás observar la formulación médica recomendada.",
                  buttonText: "Aceptar",
                  color: Theme.of(context).primaryColor,
                  urlImage: 'assets/data/image/medicamentos.png',
                ),
              );
            }
          } catch (e) {
            print("Error " + e.toString());
          }
        },
        tooltip: 'Continuar',
        label: Text(
          'Continuar',
          style: TextStyle(fontSize: 16.0),
        ),
        icon: Icon(
          Icons.local_hospital,
          size: 19.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _itemsSymptoms() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 10.0),
          ListTile(
            title: Text(
              " Ayúdanos a determinar tu enfermedad ",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            leading: Image.asset(
              'assets/data/image/helpus.png',
              height: 80.0,
            ),
          ),
          Divider(
            thickness: 1.2,
            height: 25.0,
          ),
          Icon(
            Icons.arrow_drop_down_circle,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _listSymptomTile(String symptom, int i) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            if (_checkbox[i]) {
              setState(() {
                _checkbox[i] = false;
              });
            } else {
              setState(() {
                _checkbox[i] = true;
              });
            }
          },
          title: Text(symptom),
          trailing: Checkbox(
            value: _checkbox[i],
            onChanged: (value) {
              setState(() {
                _checkbox[i] = value;
              });
            },
          ),
        ),
        Divider(
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }

  int _determineDisease() {
    List<int> cuarto = new List<int>(4);

    cuarto[0] = 0;
    cuarto[1] = 0;
    cuarto[2] = 0;
    cuarto[3] = 0;

    for (var i = 0; i < _checkbox.length; i++) {
      if (i >= 0 && i < 3) {
        if (_checkbox[i]) cuarto[0]++;
      }
      if (i >= 3 && i < 7) {
        if (_checkbox[i]) cuarto[1]++;
      }
      if (i >= 7 && i < 11) {
        if (_checkbox[i]) cuarto[2]++;
      }
      if (i >= 11 && i < 15) {
        if (_checkbox[i]) cuarto[3]++;
      }
    }

    var max = 0;
    var position = 0;

    for (var i = 0; i < 4; i++) {
      if (cuarto[i] > max) {
        max = cuarto[i];
        position = i;
      }
    }

    return position;
  }
}
