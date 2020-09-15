import 'package:hand_doc/src/classes/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBUtil {
  static const nameDB = 'handdoc.db';

  static Future<bool> databaseExists() async {
    return databaseFactory
        .databaseExists(join(await getDatabasesPath(), nameDB));
  }

  static Future<Database> createDB() async {
    Database database;
    try {
      database = await openDatabase(
        join(await getDatabasesPath(), nameDB),
        onCreate: (Database db, int version) {
          return db.execute(
            '''CREATE TABLE IF NOT EXISTS Users (
              id	INTEGER PRIMARY KEY AUTOINCREMENT,
              name	TEXT NOT NULL,
              lastName	TEXT NOT NULL,
              phone		TEXT NOT NULL,
              personalIdentification INTEGER NOT NULL UNIQUE,
              genre TEXT NOT NULL,
              email	TEXT NOT NULL UNIQUE,
              loggedIn INTEGER DEFAULT 0,
              password	TEXT NOT NULL,
              birthday	TEXT NOT NULL,
              height	REAL NOT NULL,
              weight	REAL NOT NULL,
              disease INTEGER NOT NULL DEFAULT 0,
              save INTEGER NOT NULL DEFAULT 0
              )''',
          );
        },
        version: 1,
      );
    } catch (e) {
      print("Problemas para crear base de datos: " + e.toString());
    }
    return database;
  }

  static Future<Database> database() async {
    return openDatabase(join(await getDatabasesPath(), nameDB));
  }

  static Future<int> countUsers([String condition = '1 = 1']) async {
    try {
      final Database db = await database();
      var result = await db
          .rawQuery('SELECT count(*) as count FROM Users WHERE $condition;');
      db.close();
      return result[0]['count'];
    } catch (e) {
      print("Problema en la consulta: " + e.toString());
    }
    return 0;
  }

  // Read with condition
  static Future<List<User>> readIf(String table, String condition) async {
    try {
      final Database db = await database();

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
          genre: map[i]['genre'],
          phone: map[i]['phone'],
          email: map[i]['email'],
          password: map[i]['password'],
          birthday: map[i]['birthday'],
          height: map[i]['height'],
          weight: map[i]['weight'],
          disease: map[i]['disease'],
        );
      });
    } catch (e) {
      print("Problema al leer los usuarios: " + e.toString());
    }
    return List<User>();
  }

  static Future<List<Map<String, dynamic>>> usersSaved() async {
    try {
      final Database db = await database();

      final List<Map<String, dynamic>> result = await db.query(
        'Users',
        columns: ['id', 'name', 'lastName', 'save'],
        where: 'save = ? AND loggedIn = ?',
        whereArgs: [1, 0],
      );

      db.close();

      return result;
    } catch (e) {
      print("Problema al leer los usuarios" + e.toString());
    }
    return null;
  }

  // Read if there are users in database
  static Future<User> readUser() async {
    try {
      final Database db = await database();

      final List<Map<String, dynamic>> result = await db.query(
        'Users',
        where: 'loggedIn = ?',
        whereArgs: [1],
        limit: 1,
      );

      db.close();

      return User(
        id: result[0]['id'],
        name: result[0]['name'],
        lastName: result[0]['lastName'],
        personalIdentification: result[0]['personalIdentification'],
        loggedIn: result[0]['loggedIn'],
        genre: result[0]['genre'],
        phone: result[0]['phone'],
        email: result[0]['email'],
        password: result[0]['password'],
        birthday: result[0]['birthday'],
        height: result[0]['height'],
        weight: result[0]['weight'],
        disease: result[0]['disease'],
        save: result[0]['save'],
      );
    } catch (e) {
      print("Problema al leer los usuarios" + e.toString());
    }
    return null;
  }

  // Insert user
  static Future<bool> insertUser(User user) async {
    try {
      final Database db = await database();
      user.loggedIn = 1;

      await db.insert(
        'Users',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
        nullColumnHack: 'id',
      );
      db.close();
      return true;
    } catch (e) {
      print("Problema al insertar usuario: " + e.toString());
      return false;
    }
  }

  static Future<bool> loginUser(
    String email,
    String password,
    bool save,
  ) async {
    try {
      final Database db = await database();
      final List<Map<String, dynamic>> users = await db.query(
        'Users',
        columns: ['id'],
        where: '(email = ? OR personalIdentification = ?) AND password = ?',
        whereArgs: [email, email, password],
        limit: 1,
      );
      db.close();

      if (users.length == 0) return false;

      await updateUsers({'loggedIn': 0});

      return await updateUsers(
        {
          'loggedIn': 1,
          'save': (save ? 1 : 0),
        },
        where: 'id = ?',
        whereArgs: [users[0]['id']],
      );
    } catch (e) {
      print("Problema en la consulta: " + e.toString());
    }
    return false;
  }

  static Future<bool> updateUsers(
    Map<String, dynamic> values, {
    String where,
    List whereArgs,
  }) async {
    try {
      final db = await database();
      await db.update(
        'Users',
        values,
        where: where,
        whereArgs: whereArgs,
      );
      db.close();
    } catch (e) {
      print("Problema al actualizar usuario" + e.toString());
      return false;
    }
    return true;
  }

  static Future<bool> updateUser(User user) async {
    try {
      final db = await database();

      await db.update(
        'Users',
        user.toMap(),
        where: "id = ?",
        whereArgs: [user.id],
      );
      db.close();
      return true;
    } catch (e) {
      print("Problema al actualizar usuario" + e.toString());
    }
    return false;
  }

  //Delete user
  static Future<void> deleteUser(int id) async {
    try {
      final db = await database();

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
