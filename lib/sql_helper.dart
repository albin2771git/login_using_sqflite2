import 'package:sqflite/sqflite.dart' as sql;

// ignore: camel_case_types
class Sql_Helper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name TEXT,
    email TEXT,
    password TEXT,
    Conformpassword TEXT,
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP

  )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('kinda.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  //--------create new items in SignUpdata (List)----------

  static Future<int> createItem(
      String name,
      String email,
      String password,
      // ignore: non_constant_identifier_names
      String Conformpassword) async {
    final db = await Sql_Helper.db();
    final data = {
      'name': name,
      'email': email,
      'password': password,
      'Conformpassword': Conformpassword
    };
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  //----------read items-------------

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await Sql_Helper.db();
    return db.query('items', orderBy: 'id');
  }
}
