import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login_using_sqflite2/sql_helper.dart';
import 'package:login_using_sqflite2/sql_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> signUpdata = [];
  bool isLoading = true;
  void refreshdata() async {
    final data = await Sql_Helper.getItems();
    setState(() {
      signUpdata = data;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    refreshdata();
    // Loading the diary when the app starts
  }

  // static Future<List<Map<String, dynamic>>> getItem(int id) async {
  //   final db = await Sql_Helper.db();
  //   return db.query('items', where: "name", whereArgs: [id], limit: 1);
  // }

  // void delete(int id) async {
  //   await Sql_Helper.Delete(id);
  //   refreshdata();
  // }
  void delete(int id) async {
    await Sql_Helper.deleteItem(id);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Sucessfully delete a user')));
    refreshdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('login')),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                    itemCount: signUpdata.length,
                    itemBuilder: (context, index) => Card(
                          color: Colors.amber[200],
                          margin: EdgeInsets.all(10),
                          child: ListTile(
                            title: Text(
                              signUpdata[index]['name'],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  delete(signUpdata[index]['id']);
                                },
                                icon: Icon(Icons.delete)),
                          ),
                        ))));
  }
}
