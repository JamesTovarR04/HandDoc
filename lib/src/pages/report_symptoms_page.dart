import 'package:flutter/material.dart';
import 'package:hand_doc/src/providers/menu_provider.dart';

class ReportSymptomsPage extends StatefulWidget {
  final route = 'report/';
  ReportSymptomsPage({Key key}) : super(key: key);

  @override
  _ReportSymptomsPageState createState() => _ReportSymptomsPageState();
}

class _ReportSymptomsPageState extends State<ReportSymptomsPage> {
  List<bool> _checkbox = new List<bool>(18);
  //----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _checkbox[0] = false;
    _checkbox[1] = false;
    _checkbox[2] = false;
    _checkbox[3] = false;
    _checkbox[4] = false;

    _checkbox[5] = false;
    _checkbox[6] = false;
    _checkbox[7] = false;
    _checkbox[8] = false;
    _checkbox[9] = false;

    _checkbox[10] = false;
    _checkbox[11] = false;
    _checkbox[12] = false;
    _checkbox[13] = false;
    _checkbox[14] = false;
    _checkbox[15] = false;
    _checkbox[16] = false;
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
        child: _itemsSymptoms(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.remove_red_eye,
          size: 35.0,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {},
      ),
    );
  }

  Widget _itemsSymptoms() {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 30.0),
          Text(
            " Ayúdanos a determinar tu enfermedad ",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          SizedBox(height: 10.0),
          Icon(
            Icons.assignment,
            size: 60.0,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(height: 40.0),
          _listSymptom("Dolor agudo en el pecho", 0),
          _listSymptom("Dificultad para respirar", 1),
          _listSymptom("Respiración rápida", 2),
          _listSymptom("Escalofríos", 3),
          //-------------------------------------
          _listSymptom("Dolor de abdomen", 4),
          _listSymptom("Cólicos", 5),
          _listSymptom("Diarrea", 6),
          _listSymptom("Flatulencias", 7),
          _listSymptom("Dolor de cabeza", 8),
          //-------------------------------------
          _listSymptom("Dolor en las articulaciones", 9),
          _listSymptom("Dolor en la parte posterior de los ojos", 10),
          _listSymptom("Erupciones o manchas rojas", 11),
          _listSymptom("Facilidad para desarrollar hematomas", 12),
          //-------------------------------------
          _listSymptom("Tos con flema, seca o crónica", 13),
          _listSymptom("Congestión nasal", 14),
          _listSymptom("Dificultad para respirar", 15),
          _listSymptom("Dolor de garganta", 16),

          SizedBox(height: 65.0),
        ],
      ),
    );
  }

  Widget _listSymptom(String symptom, int i) {
    return Column(
      children: [
        ListTile(
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
}
