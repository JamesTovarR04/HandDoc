import 'package:hand_doc/src/classes/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBUtil {
  static const nameDB = 'handdoc.db';
  // Method to define the path of database
  static final Future<Database> database = openReadOnlyDatabase(
    join(getDatabasesPath().toString(), nameDB),
  );

  // Execute queries in database
  static final Future<Database> createBD = openDatabase(
    join(getDatabasesPath().toString(), nameDB),
    onCreate: (Database db, int version) {
      return db.execute(
        '''CREATE TABLE IF NOT EXISTS user (
	id	INTEGER PRIMARY KEY AUTOINCREMENT,
	name	TEXT NOT NULL,
	lastName	TEXT NOT NULL,
	phone		TEXT NOT NULL,
	personalIdentification	INTEGER NOT NULL UNIQUE,
	email	TEXT NOT NULL UNIQUE,
	loggedIn INTEGER DEFAULT 0,
	password	TEXT NOT NULL,
	birthday	TEXT NOT NULL,
	height	REAL NOT NULL,
	weight	REAL NOT NULL
)''',
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

      final List<Map<String, dynamic>> map =
          await db.query('user', where: 'loggedIn = ?', whereArgs: [1]);

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
      user.loggedIn = 1;

      await db.insert(
        'user',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
        nullColumnHack: 'id',
      );
    } catch (e) {
      print("Problema al insertar usuario" + e.toString());
    }
  }

  // Update user if condition is true
  static Future<int> updateUserIf(User user) async {
    List<User> staticUser = new List<User>();

    try {
      final db = await database;

      await DBUtil.readIf('user',
              'email = "${user.email}" AND password = "${user.password}"')
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
      return 0;
    }
    return 1;
  }

  static Future<int> updateUser(User user) async {
    try {
      final db = await database;

      await db.update(
        'user',
        user.toMap(),
        where: "id = ?",
        whereArgs: [user.id],
      );
      return 1;
    } catch (e) {
      print("Problema al actualizar usuario" + e.toString());
    }
    return 0;
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
