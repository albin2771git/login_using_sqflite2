import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_using_sqflite2/screens/firstScreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.deepPurple),
    //home: LoginPage(),
    home: FirstScreen(),
  ));
}
