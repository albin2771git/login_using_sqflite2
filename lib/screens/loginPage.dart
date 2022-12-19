// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login_using_sqflite2/screens/HomeScreen.dart';
import 'package:login_using_sqflite2/screens/secondScreen.dart';
import 'package:login_using_sqflite2/screens/signUp.dart';
import 'package:login_using_sqflite2/sql_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
//------------list-----------------//

  List<Map<String, dynamic>> signUpdata = [];

  //----------------global key--------------//
  var formkey = GlobalKey<FormState>();

  //--------------controllers---------------//
  final TextEditingController useremail = TextEditingController();
  final TextEditingController userpassword = TextEditingController();

  //-----------fetch data from database-------------//

  void refreshdata() async {
    final data = await Sql_Helper.getItems();
    setState(() {
      signUpdata = data;

      // isLoading = false;
    });
  }

  void validationdata(String email, String password) async {
    if (email == "albinad@" && password == '123456') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      var datafetch = await Sql_Helper.validation(email, password);
      if (datafetch.isNotEmpty) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SecondScreen()));
        print('Login Success');
      } else if (datafetch.isEmpty) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignUp()));
        print('Login faild');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: formkey,
          child: Center(
              child: Container(
            width: 300,
            height: 450,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                TextFormField(
                  controller: useremail,
                  decoration: InputDecoration(
                    label: Text("enter your email"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24)),
                  ),
                  validator: (loginemail) {
                    if (loginemail!.isEmpty || !loginemail.contains('@')) {
                      return "enter a valid email";
                    } else {
                      return null;
                    }
                  },
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  controller: userpassword,
                  decoration: InputDecoration(
                    label: Text("enter your password"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24)),
                  ),
                  validator: (loginpassword) {
                    if (loginpassword!.isEmpty || loginpassword.length < 3) {
                      return "enter a valid name";
                    } else {
                      return null;
                    }
                  },
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      // if (useremail.text == useremailcheck) {
                      //   Navigator.pushReplacement(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => HomeScreen()));
                      // }
                      final validate = formkey.currentState!.validate();
                      if (validate) {
                        validationdata(useremail.text, userpassword.text);
                      }
                    },
                    child: Text('Login'))
              ],
            ),
          ))),
    );
  }
}
