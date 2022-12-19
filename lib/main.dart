import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_using_sqflite2/screens/HomeScreen.dart';
import 'package:login_using_sqflite2/screens/loginPage.dart';
import 'package:login_using_sqflite2/screens/signUp.dart';
import 'package:login_using_sqflite2/screens/sucess.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.cyan),
    //home: LoginPage(),
    home: SignUp(),
  ));
}
