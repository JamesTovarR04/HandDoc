import 'package:flutter/material.dart';
import 'package:hand_doc/src/classes/user.dart';
import 'package:hand_doc/src/pages/report_symptoms_page.dart';
import 'package:hand_doc/src/providers/menu_provider.dart';
import 'package:hand_doc/src/utils/DB_util.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

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
      if (user.length > 0)
        setState(() {
          _user = user[0];
        });
    });
  }

  //----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    Menu menu = new Menu(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('HandDoc'),
      ),
      drawer: Drawer(
        child: menu.drawer,
      ),
      body: _createWave(),
    );
  }

  Widget _itemsHome() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            'assets/data/image/logo.png',
            height: 150.0,
          ),
          SizedBox(height: 30.0),
          _createTextUser(),
          Divider(
            color: Colors.grey,
            thickness: 1.0,
            height: 40.0,
          ),
          Text(
            "Selecciona una de las opciones:",
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(height: 20.0),
          //----------------------------------------------------------------------
          _createButtonEmergency(),
          SizedBox(height: 20.0),
          Text(
            "Si consideras que tu estado general es crítico.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15.0),
          ),
          SizedBox(height: 30.0),
          _createButtonReportSymptoms(),
          SizedBox(height: 20.0),
          Text(
            "Si tu estado requiere tratamiento doméstico.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15.0),
          ),
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
        fontSize: 35.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  //----------------------------------------------------------------------------
  Widget _createButtonEmergency() {
    return RaisedButton(
      color: Colors.red,
      elevation: 7.0,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(18.0),
      ),
      textColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text("EMERGENCIA",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            )),
      ),
      onPressed: () {},
    );
  }

  //----------------------------------------------------------------------------
  Widget _createButtonReportSymptoms() {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      elevation: 7.0,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(18.0),
      ),
      textColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          "Reportar síntomas",
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      onPressed: () {
        Navigator.pushNamed(context, ReportSymptomsPage().route);
      },
    );
  }

  Widget _createWave() {
    return Stack(
      children: <Widget>[
        ListView(
          children: [
            SizedBox(height: 165.0),
            Container(
              height: MediaQuery.of(context).size.height,
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
          ],
        ),
        _itemsHome(),
      ],
    );
  }
}
