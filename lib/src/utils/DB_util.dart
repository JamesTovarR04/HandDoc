import 'package:hand_doc/src/classes/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBUtil {
  // Method to define the path of database
  static final Future<Database> database = openReadOnlyDatabase(
    join(getDatabasesPath().toString(), 'handdoc.db'),
  );

  // Execute queries in database
  static final Future<Database> createBD = openDatabase(
    join(getDatabasesPath().toString(), 'handdoc.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE IF NOT EXISTS usuario_base(id INTEGER PRIMARY KEY, logeado TEXT, idUsuario INTEGER, correo TEXT)",
      );
    },
    version: 1,
  );

  // Read with condition
  static Future<List<User>> readIf(String table, String condition) async {
    try {
      final Database db = await database;

      final List<Map<String, dynamic>> map = await db.query(
        "$table",
        where: condition,
      ); // Convert List<Map<String, dynamic> en List<User>.

      return List.generate(map.length, (i) {
        return User(
          id: map[i]['id'],
          name: map[i]['name'],
          lastName: map[i]['lastName'],
          personalIdentification: map[i]['personalIdentification'],
          loggedIn: map[i]['loggedIn'],
          phone: map[i]['phone'],
          email: map[i]['email'],
          password: map[i]['password'],
          birthday: map[i]['birthday'],
          height: map[i]['height'],
          weight: map[i]['weight'],
        );
      });
    } catch (e) {
      print("Problema al leer los usuarios" + e.toString());
    }
  }

  // Read if there are users in database
  static Future<List<User>> readUser() async {
    try {
      final Database db = await database;

      final List<Map<String, dynamic>> map = await db.query('user');

      // Convert List<Map<String, dynamic> en List<User>.
      return List.generate(map.length, (i) {
        return User(
          id: map[i]['id'],
          name: map[i]['name'],
          lastName: map[i]['lastName'],
          personalIdentification: map[i]['personalIdentification'],
          loggedIn: map[i]['loggedIn'],
          phone: map[i]['phone'],
          email: map[i]['email'],
          password: map[i]['password'],
          birthday: map[i]['birthday'],
          height: map[i]['height'],
          weight: map[i]['weight'],
        );
      });
    } catch (e) {
      print("Problema al leer los usuarios" + e.toString());
    }
  }

  // Insert user
  static Future<void> insertUser(User user) async {
    try {
      final Database db = await database;

      await db.insert(
        'user',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("Problema al insertar usuario" + e.toString());
    }
  }

  // Update user if condition is true
  static Future<void> updateUserIf(User user) async {
    List<User> staticUser = new List<User>();

    try {
      final db = await database;

      DBUtil.readIf(
              'user', 'email = ${user.email} AND password = ${user.password}')
          .then((user) {
        staticUser = user;
      });

      staticUser[0].loggedIn = 1;

      if (staticUser.length == 1) {
        await db.update(
          'user',
          staticUser[0].toMap(),
          where: 'id = ?',
          whereArgs: [staticUser[0].id],
        );
      }
    } catch (e) {
      print("Problema al actualizar usuario" + e.toString());
    }
  }

  static Future<void> updateUser(User user) async {
    try {
      final db = await database;

      await db.update(
        'user',
        user.toMap(),
        where: "id = ?",
        whereArgs: [user.id],
      );
    } catch (e) {
      print("Problema al actualizar usuario" + e.toString());
    }
  }

  //Delete user
  static Future<void> deleteUser(int id) async {
    try {
      final db = await database;

      await db.delete(
        'user',
        where: "id = ?",
        whereArgs: [id],
      );
    } catch (e) {
      print("Problema al eliminar usuario" + e.toString());
    }
  }
}
