import 'package:flutter/cupertino.dart';
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
    return sql.openDatabase('kind.db', version: 1,
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

  // static Future<List<Map<String, dynamic>>> getItem(int id) async {
  //   final db = await Sql_Helper.db();
  //   return db.query('items', where: "id=?", whereArgs: [id], limit: 1);
  // }

  static Future<List<Map>> validation(String email, String password) async {
    final db = await Sql_Helper.db();
    final datafetch = await db.rawQuery(
        "SELECT * FROM items WHERE email='$email' AND password='$password' ");
    // print(datafetch.toString());
    if (datafetch.isNotEmpty) {
      return datafetch;
    }
    return datafetch;
  }

  static Future<List<Map>> getAll() async {
    final db = await Sql_Helper.db();
    final datafetch = db.rawQuery("SELECT * FROM user");
    return datafetch;
  }

  //--------------------update--------------//
  static Future<int> updateItems(int id, String name, String email,
      String password, String Conformpassword) async {
    final db = await Sql_Helper.db();
    final signUpdata = {
      'name': name,
      'email': email,
      'password': password,
      'Conformpassword': Conformpassword,
      'createdAt': DateTime.now().toString()
    };
    final result =
        await db.update('items', signUpdata, where: "id=?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await Sql_Helper.db();
    try {
      await db.delete("items", where: "id=?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item:$err");
    }
  }

  static Future<void> Delete(int id) async {
    final db = await Sql_Helper.db();
    db.delete('user', where: 'id = ?', whereArgs: [id]);
  }
}
