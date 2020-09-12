import 'package:flutter/cupertino.dart';
import 'package:hand_doc/src/classes/user.dart';
import 'package:hand_doc/src/utils/DB_util.dart';

class AccessUtil {
  // Connect user to system
  static Future<int> loginUser(String email, String password) async {
    User user = new User();
    user.email = email;
    user.password = password;

    try {
      if (await DBUtil.updateUserIf(user) == 1) return 1;
    } catch (e) {
      return 0;
    }
    return 0;
  }

  static Future<int> registerUser(User user) async {
    // Create user record and allow login
    try {
      await DBUtil.insertUser(user);
    } catch (e) {
      return 0;
    }

    return 1;
  }

  static Future<int> checkSession(BuildContext context) async {
    var longitud = 0;

    try {
      await DBUtil.createBD;
    } catch (e) {
      print("Problemas para crear base de datos checkSession" + e.toString());
    }
    //--------------------------------------------------------------------------

    await DBUtil.readIf('user', 'loggedIn = 1').then((user) {
      longitud = user.length;
    });

    if (longitud != 0) return 1;
    return 0;
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
  static Future<int> logout() async {
    List<User> userI = new List<User>();
    try {
      await DBUtil.readIf('user', 'loggedIn = 1').then((user) {
        userI = user;
        userI[0].loggedIn = 0;
      });
      await DBUtil.updateUser(userI[0]);
      return 1;
    } catch (e) {
      print("Probelmas al salir" + e.toString());
      return 0;
    }
  }
}
