import 'package:flutter/material.dart';
import 'package:hand_doc/src/pages/home_page.dart';
import 'package:hand_doc/src/pages/login_page.dart';
import 'package:hand_doc/src/pages/medicine_page.dart';
import 'package:hand_doc/src/pages/profile_page.dart';
import 'package:hand_doc/src/pages/select_user.dart';
import 'package:hand_doc/src/utils/access_util.dart';
import 'package:hand_doc/src/utils/DB_util.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<Widget> _listaUsuarios;

  @override
  void initState() {
    super.initState();
    _listaUsuarios = [];
    DBUtil.usersSaved().then((users) {
      if (users != null) {
        _listaUsuarios = users.map((user) {
          String name = user['name'] + ' ' + user['lastName'][0] + '.';
          return _userItemList(name, user['id']);
        }).toList();
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).accentColor
              ],
              radius: 0.9,
            ),
          ),
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/data/image/icon_white.png',
                  height: 80.0,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 9.0),
                  child: Text(
                    "HandDoc",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontFamily: 'CaviarDreams',
                      letterSpacing: 3.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        _itemList(Icons.home, "Inicio", context, HomePage().route),
        _itemList(Icons.person, "Perfil", context, ProfilePage().route),
        _itemList(
            Icons.assignment_ind, "Fórmula", context, MedicinePage().route),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(
            color: Theme.of(context).primaryColor,
            height: 15,
            thickness: 0.5,
          ),
        ),
        _itemList(Icons.info_outline, "Términos y Condiciones", context,
            'termsprivacy/'),
        //----------------------------------------------------------------------
        ListTile(
          title: InkWell(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    Icons.power_settings_new,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text("Cerrar Sesión"),
              ],
            ),
            onTap: () async {
              //----------------------------------------------------------------
              int codeLogout = await AccessUtil.logout();
              if (codeLogout == 1)
                Navigator.pushNamed(context, SelectUserPage().route);
              else if (codeLogout == 2)
                Navigator.pushNamed(context, LoginPage().route);
              //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              //----------------------------------------------------------------
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(
            color: Theme.of(context).primaryColor,
            height: 15,
            thickness: 0.5,
          ),
        ),
        _addUser(),
        ..._listaUsuarios,
      ],
    );
  }

  Widget _userItemList(String name, int id) {
    return ListTile(
      title: InkWell(
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(
                Icons.account_circle,
                color: Colors.black45,
              ),
            ),
            Text(name),
          ],
        ),
        onTap: () async {
          await AccessUtil.loginSavedUser(id);
          Navigator.pushNamed(context, HomePage().route);
        },
      ),
    );
  }

  Widget _addUser() {
    return ListTile(
      title: InkWell(
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(
                Icons.add_circle,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text('Agregar Usuario'),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, LoginPage().route);
        },
      ),
    );
  }

  Widget _itemList(
      IconData icon, String name, BuildContext context, String route) {
    return ListTile(
      title: InkWell(
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(
                icon,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(name),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }
}
