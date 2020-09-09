import 'package:flutter/cupertino.dart';
import 'package:hand_doc/src/classes/user.dart';
import 'package:hand_doc/src/pages/login_page.dart';
import 'package:hand_doc/src/utils/DB_util.dart';

class AccessUtil {
  static void loginUser(BuildContext context, String email, String password) {
    User user = new User();
    user.email = email;
    user.password = password;

    DBUtil.updateUserIf(user);

    //Navigator.pushNamed(context, 'home/');
  }

  static void registerUser(BuildContext context, User user) {
    try {
      DBUtil.createBD;
    } catch (e) {
      print("Problemas para crear base de datos" + e.toString());
    }

    // Create user record and allow login
    DBUtil.insertUser(user);
    Navigator.pushNamed(context, LoginPage().route);
    print("Aún no se ha configurado la ruta de acceso para la app login");
  }

  static void checkSession(BuildContext context, String condition) {
    var longitud = 0;

    try {
      DBUtil.createBD;
    } catch (e) {
      print("Problemas para crear base de datos checkSession" + e.toString());
    }
    //--------------------------------------------------------------------------

    DBUtil.readIf('user', 'loggedIn = 1').then((user) {
      longitud = user.length;
    });

    if (longitud == 0)
      Navigator.pushNamed(context, LoginPage().route);
    else {
      Navigator.pushNamed(context, LoginPage().route);
      print("Aún no se ha configurado la ruta de acceso para la app");
    }
  }

  // Check if user is registered
  static bool checkIfRegistered(String personalIdentification) {
    int registry = 0;
    DBUtil.readIf('user', "personalIdentification = $personalIdentification")
        .then((user) {
      registry = user.length;
    });

    return registry == 1 ? true : false;
  }

  // Logged out user
  static void logout(BuildContext context) {
    User user = new User();
    DBUtil.readIf('user', 'loggedIn = 1').then((user) {
      user = user;
      user[0].loggedIn = 0;
    });
    DBUtil.updateUser(user);
    Navigator.pushNamed(context, LoginPage().route);
  }
}
