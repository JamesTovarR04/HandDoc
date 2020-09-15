import 'package:flutter/material.dart';
import 'package:hand_doc/src/classes/user.dart';
import 'package:hand_doc/src/pages/report_symptoms_page.dart';
import 'package:hand_doc/src/providers/menu_provider.dart';
import 'package:hand_doc/src/utils/DB_util.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:hand_doc/src/pages/triage_page.dart';

class HomePage extends StatefulWidget {
  final route = "home/";
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User _user = new User();
  //----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _user.name = "";

    DBUtil.readUser().then((user) {
      if (user != null)
        setState(() {
          _user = user;
        });
    });
  }

  //----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HandDoc',
          style: TextStyle(
            fontFamily: 'CaviarDreams',
          ),
        ),
      ),
      drawer: Drawer(
        child: Menu(),
      ),
      body: _createWave(),
    );
  }

  Widget _createWave() {
    return Stack(
      children: <Widget>[
        Container(
          decoration: new BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/data/image/doctors.png'),
              alignment: Alignment.bottomCenter,
            ),
          ),
        ),
        Container(
          height: 100,
          child: RotatedBox(
            quarterTurns: 2,
            child: WaveWidget(
              config: CustomConfig(
                gradients: [
                  [
                    Colors.white,
                    Theme.of(context).primaryColor,
                  ],
                  [Theme.of(context).primaryColor, Colors.white],
                  [Colors.white, Colors.white],
                  [Colors.white, Colors.white],
                ],
                durations: [35000, 19440, 10800, 6000],
                heightPercentages: [0.20, 0.23, 0.25, 0.30],
                gradientBegin: Alignment.topRight,
                gradientEnd: Alignment.bottomLeft,
              ),
              waveAmplitude: 0,
              size: Size(
                double.infinity,
                double.infinity,
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          child: _itemsHome(),
        )
      ],
    );
  }

  Widget _itemsHome() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            'assets/data/image/icon_green.png',
            height: 90.0,
          ),
          SizedBox(height: 15.0),
          _createTextUser(),
          Divider(
            color: Colors.grey,
            thickness: 1.0,
            height: 40.0,
          ),
          //----------------------------------------------------------------------
          _createButtonEmergency(),
          SizedBox(height: 15.0),
          _createButtonReportSymptoms(),
          SizedBox(height: 30.0),
        ],
      ),
    );
  }

  //------------------------------------------------------------------------------
  // creating separated Widgets
  Widget _createTextUser() {
    return Text(
      "Hola, " + _user.name.split(' ')[0],
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 30.0,
        color: Color.fromARGB(255, 60, 60, 60),
        //fontWeight: FontWeight.bold,
      ),
    );
  }

  //----------------------------------------------------------------------------
  Widget _createButtonEmergency() {
    return Card(
      elevation: 12.0,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.zero,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
            ),
            child: Image.asset(
              'assets/data/image/emergencia.png',
              height: 140.0,
              width: 80.0,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    '¿Necesitas asistencia médica en este momento?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                RaisedButton.icon(
                  icon: Icon(Icons.local_hospital),
                  color: Colors.red,
                  elevation: 7.0,
                  textColor: Colors.white,
                  label: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("EMERGENCIA",
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, TriagePage().route);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  //----------------------------------------------------------------------------
  Widget _createButtonReportSymptoms() {
    return Card(
      elevation: 12.0,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.zero,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
            ),
            child: Image.asset(
              'assets/data/image/diagnostico2.png',
              height: 140.0,
              width: 80.0,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    '¿Estás enfermo?, envíanos tus síntomas y obtén ayuda',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                    ),
                  ),
                ),
                RaisedButton.icon(
                  icon: Icon(Icons.star),
                  color: Theme.of(context).primaryColor,
                  elevation: 7.0,
                  textColor: Colors.white,
                  label: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: 8.0),
                    child: Text('Reportar síntomas',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, ReportSymptomsPage().route);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
