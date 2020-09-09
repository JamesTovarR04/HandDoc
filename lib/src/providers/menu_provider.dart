import 'package:flutter/material.dart';
import 'package:hand_doc/src/utils/access_util.dart';

class Menu {
  var _itemsDrawer;

  Menu(BuildContext context) {
    this._itemsDrawer = ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.deepOrange,
          ),
          child: Center(
            child: Image.asset(
              'assets/data/image/logo.png',
              height: 100.0,
            ),
          ),
        ),
        _itemList(Icons.home, "Inicio", context, 'init/'),
        _itemList(Icons.person, "Perfil", context, 'profile/'),
        _itemList(Icons.info_outline, "Términos y Condiciones", context,
            'termsprivacy/'),
        //----------------------------------------------------------------------
        ListTile(
          title: InkWell(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.power_settings_new),
                ),
                Text("Cerrar Sesión"),
              ],
            ),
            onTap: () {
              //----------------------------------------------------------------
              AccessUtil.logout(context);
              //----------------------------------------------------------------
            },
          ),
        ),
      ],
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
              child: Icon(icon),
            ),
            Text(name),
          ],
        ),
        onTap: () {
          // Navigator.pushNamed(context, route);
        },
      ),
    );
  }

  ListView barra() {
    return this._itemsDrawer;
  }
}
