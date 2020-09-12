import 'package:flutter/material.dart';
import 'package:hand_doc/src/providers/menu_provider.dart';
import 'package:hand_doc/src/providers/custom_dialog.dart';

class TriagePage extends StatefulWidget {
  final route = '/triage';

  _TriagePageState createState() => _TriagePageState();
}

enum Answers { YES, NO, MAYBE }

class _TriagePageState extends State<TriagePage> {
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Menu menu = Menu(context);

    return Scaffold(
      drawer: Drawer(child: menu.drawer),
      appBar: AppBar(
          title: const Text('TRIAGE'),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10.0),
              child: CircleAvatar(
                child: Text(
                  'US',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                backgroundColor: Colors.white,
              ),
            ),
          ],
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          )),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                top: 10.0, bottom: 5.0, left: 10.0, right: 10.0),
            child: Card(
              elevation: 7.0,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0),
                    child: Image.asset(
                      "assets/data/image/corazon.png",
                      height: 70.0,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          style:
                              TextStyle(color: Colors.black87, fontSize: 14.0),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  'El triage es un sistema de ​selección y clasificación de pacientes en los servicios de urgencia,',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text:
                                  ' basado en sus necesidades terapéuticas y los recursos disponibles para atenderlo.',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: _triageBody(),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: SizedBox(),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => CustomDialog(
              title: '¡Recibimos tu solucitud!',
              description:
                  "El hospital municipal de Algeciras ha recibido tu solicitud y tus datos para la agilidad de la urgencia médica, en breve la ambulancia y el correspondiente personal médico se comunicará contigo para ir inmediatamente al lugar donde te encuentras.",
              buttonText: "Aceptar",
              color: _triage[_currentStep]['color'],
              urlImage: 'assets/data/image/amb.gif',
            ),
          );
        },
        tooltip: 'Continuar',
        backgroundColor: _triage[_currentStep]['color'],
        label: Text(
          'Continuar',
          style: TextStyle(fontSize: 16.0),
        ),
        icon: Icon(
          Icons.local_hospital,
          size: 19.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  List _triage = <Map<String, dynamic>>[
    {
      'title': 'TRIAGE I',
      'content': TextSpan(
        style: TextStyle(color: Colors.white, fontSize: 13.0),
        children: <TextSpan>[
          TextSpan(text: 'Requiere '),
          TextSpan(
            text: 'atención inmediata',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: '. La condición clínica del paciente representa un '),
          TextSpan(
            text: 'riesgo vital ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
              text:
                  'y necesita maniobras de reanimación por su compromiso ventilatorio, respiratorio, hemodinámico o neurológico, perdida de miembro u órgano u otras condiciones que por norma exijan '),
          TextSpan(
            text: 'atención inmediata.',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      'color': Colors.red[800]
    },
    {
      'title': 'TRIAGE II',
      'content': TextSpan(
        style: TextStyle(color: Colors.white, fontSize: 13.0),
        children: <TextSpan>[
          TextSpan(text: 'La condición clínica del paciente puede '),
          TextSpan(
            text:
                'evolucionar hacia un rá-pido deterioro o a su muerte, o incrementar el riesgo',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
              text:
                  ' para la pérdida de un miembro u órgano, por lo tanto, requiere una '),
          TextSpan(
            text: 'atención que no debe superar los treinta (30) minutos.',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      'color': Colors.red[600]
    },
    {
      'title': 'TRIAGE III',
      'content': TextSpan(
        style: TextStyle(color: Colors.white, fontSize: 13.0),
        children: <TextSpan>[
          TextSpan(text: 'La condición clínica del paciente '),
          TextSpan(
            text:
                'requiere de medidas diagnósticas y terapéuticas en urgencias. ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
              text:
                  'Son aquellos pacientes que necesitan un examen complementario o un tratamiento rápido, dado que se encuentran estables desde el punto de vista fisiológico aunque su situación puede empeorar si no se actúa.'),
        ],
      ),
      'color': Colors.deepOrange[600]
    },
    {
      'title': 'TRIAGE IV',
      'content': TextSpan(
        style: TextStyle(color: Colors.white, fontSize: 13.0),
        children: <TextSpan>[
          TextSpan(text: 'El paciente presenta '),
          TextSpan(
            text:
                'condiciones médicas que no comprometen su estado general, ni representan un riesgo evidente ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
              text:
                  'para la vida o pérdida de miembro u órgano. No obstante, existen riesgos de complicación o secuelas de la enfermedad o lesión si no recibe la atención correspondiente.'),
        ],
      ),
      'color': Colors.amber[900]
    },
    {
      'title': 'TRIAGE V',
      'content': TextSpan(
        style: TextStyle(color: Colors.white, fontSize: 13.0),
        children: <TextSpan>[
          TextSpan(
              text:
                  'El paciente presenta una condición clínica relacionada con problemas agudos o crónicos sin '),
          TextSpan(
            text:
                'sin evidencia de deterioro que comprometa el estado general de paciente y no representa un riesgo evidente ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
              text: 'para la vida o la funcionalidad de miembro u órgano.'),
        ],
      ),
      'color': Colors.orange[700],
    },
  ];

  Widget _triageBody() {
    return Stepper(
      controlsBuilder: (context, {onStepCancel, onStepContinue}) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            /*if (_currentStep > 0)
              Container(
                padding: const EdgeInsets.all(0),
                height: 40,
                width: 40,
                child: FloatingActionButton(
                  child: Icon(Icons.keyboard_arrow_up),
                  onPressed: onStepCancel,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
            if (_currentStep < 4)
              Container(
                padding: const EdgeInsets.all(0),
                height: 40,
                width: 40,
                child: FloatingActionButton(
                  child: Icon(Icons.keyboard_arrow_down),
                  onPressed: onStepContinue,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),*/
          ],
        );
      },
      type: StepperType.vertical,
      physics: AlwaysScrollableScrollPhysics(),
      currentStep: _currentStep,
      onStepTapped: (value) {
        setState(() {
          _currentStep = value;
        });
      },
      onStepContinue: () {
        if (_currentStep >= 4) return;
        setState(() {
          _currentStep += 1;
        });
      },
      onStepCancel: () {
        if (_currentStep <= 0) return;
        setState(() {
          _currentStep -= 1;
        });
      },
      steps: _triage.asMap().entries.map((triage) {
        return Step(
          title: Text(
            triage.value['title'],
            style: TextStyle(color: triage.value['color']),
          ),
          content: Card(
            elevation: 9.0,
            color: triage.value['color'],
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: RichText(
                textAlign: TextAlign.justify,
                text: triage.value['content'],
              ),
            ),
          ),
          isActive: (_currentStep == triage.key),
        );
      }).toList(),
    );
  }
}
