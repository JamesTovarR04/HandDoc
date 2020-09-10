import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hand_doc/src/pages/login_page.dart';
import 'package:hand_doc/src/utils/access_util.dart';

class Menu {
  ListView _itemsDrawer;

  Menu(BuildContext context) {
    this._itemsDrawer = ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: Center(
            child: Image.asset(
              'assets/data/image/icon_white.png',
              height: 100.0,
            ),
          ),
        ),
        _itemList(Icons.home, "Inicio", context, 'init/'),
        _itemList(Icons.person, "Perfil", context, 'profile/'),
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
              if (await AccessUtil.logout() == 1)
                Navigator.pushNamed(context, LoginPage().route);
              //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
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
              child: Icon(
                icon,
                color: Theme.of(context).primaryColor,
              ),
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

  ListView get drawer {
    return _itemsDrawer;
  }
}
