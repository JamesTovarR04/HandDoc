import 'package:flutter/cupertino.dart';
import 'package:hand_doc/src/classes/user.dart';
import 'package:hand_doc/src/utils/DB_util.dart';

class AccessUtil {
  // Connect user to system
  static Future<bool> loginUser(
    String email,
    String password,
    bool save,
  ) async {
    return await DBUtil.loginUser(email, password, save);
  }

  static Future<bool> loginSavedUser(int idUser) async {
    await DBUtil.updateUsers(
      {'loggedIn': 0},
      where: 'loggedIn = ?',
      whereArgs: [1],
    );

    bool update = await DBUtil.updateUsers(
      {'loggedIn': 1},
      where: 'id = ? AND save = ?',
      whereArgs: [idUser, 1],
    );
    return update;
  }

  static Future<bool> registerUser(User user) async {
    // Create user record and allow login
    return await DBUtil.insertUser(user);
  }

  /// * 0 - User LoggedIn.
  /// * 1 - Users Saved.
  /// * 2 - There are Users.
  /// * 3 - No users.
  static Future<int> checkSession(BuildContext context) async {
    bool exitsDatabase = await DBUtil.databaseExists();

    if (!exitsDatabase) await DBUtil.createDB();

    int usersLogin = await DBUtil.countUsers('loggedIn = 1');
    if (usersLogin > 0) return 0;

    int usersSaved = await DBUtil.countUsers('save = 1');
    if (usersSaved > 0) return 1;

    int users = await DBUtil.countUsers();
    if (users > 0) return 2;

    return 3;
  }

  // Check if user is registered
  static Future<bool> checkIfRegistered(
    String personalIdentification,
    String email,
  ) async {
    int userExists = await DBUtil.countUsers(
        'personalIdentification = $personalIdentification OR email = "$email"');

    return userExists > 0;
  }

  /// Logged out user.
  /// * 0 - Error in logout
  /// * 1 - Logout but saved users
  /// * 2 - Logout and not saved users
  static Future<int> logout() async {
    bool update = await DBUtil.updateUsers(
      {
        'loggedIn': 0,
        'save': 0,
      },
      where: 'loggedIn = ?',
      whereArgs: [1],
    );
    if (!update) return 0;

    int usersSaved = await DBUtil.countUsers('save = 1');
    if (usersSaved > 0) return 1;

    return 2;
  }
}
