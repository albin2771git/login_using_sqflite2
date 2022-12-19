import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login_using_sqflite2/screens/HomeScreen.dart';
import 'package:login_using_sqflite2/screens/loginPage.dart';
import 'package:lottie/lottie.dart';

class Sucess extends StatefulWidget {
  const Sucess({super.key});

  @override
  State<Sucess> createState() => _SucessState();
}

class _SucessState extends State<Sucess> {
  @override
  void initState() {
    // TODO: implement initState

    Timer(Duration(milliseconds: 1000), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Center(
              child: Text(
        "Registerd Sucessfully",
        style: TextStyle(color: Colors.cyan, fontSize: 23),
      ))),
    );
  }
}
