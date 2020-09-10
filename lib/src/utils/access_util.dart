import 'package:flutter/cupertino.dart';
import 'package:hand_doc/src/classes/user.dart';
import 'package:hand_doc/src/pages/login_page.dart';
import 'package:hand_doc/src/pages/profile_page.dart';
import 'package:hand_doc/src/utils/DB_util.dart';

class AccessUtil {
  // Connect user to system
  static void loginUser(BuildContext context, String email, String password) {
    User user = new User();
    user.email = email;
    user.password = password;

    try {
      DBUtil.updateUserIf(user);

      Navigator.pushNamed(context, ProfilePage().route);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> registerUser(BuildContext context, User user) async {
    // Create user record and allow login
    await DBUtil.insertUser(user);
    Navigator.pushNamed(context, ProfilePage().route);
  }

  static Future checkSession(BuildContext context) async {
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
  static Future<void> logout(BuildContext context) async {
    List<User> userI = new List<User>();
    await DBUtil.readIf('user', 'loggedIn = 1').then((user) {
      userI = user;
      userI[0].loggedIn = 0;
    });
    await DBUtil.updateUser(userI[0]);
    Navigator.pushNamed(context, LoginPage().route);
  }
}
