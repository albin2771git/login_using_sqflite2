import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_using_sqflite2/screens/HomeScreen.dart';
import 'package:login_using_sqflite2/screens/loginPage.dart';
import 'package:login_using_sqflite2/screens/sucess.dart';
import 'package:login_using_sqflite2/sql_helper.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //-------controllers---------
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController Conformpassword = TextEditingController();
  //----------list-------
  List<Map<String, dynamic>> signUpdata = [];
  //----------for loading animation when date fetching from database-------
  bool isLoading = true;

//--------add item-----------//
  Future<void> addItem() async {
    await Sql_Helper.createItem(
        name.text, email.text, password.text, Conformpassword.text);

    // refreshdata();
  }

  bool viewPassword = true;
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: Center(
            child: Container(
          color: Colors.transparent,
          margin: EdgeInsets.all(20),
          width: 300,
          height: 550,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Register',
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      label: Text("enter your name"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24)),
                    ),
                    validator: (name) {
                      if (name!.isEmpty || name.length < 3) {
                        return "enter a valid name";
                      } else {
                        return null;
                      }
                    },
                    textInputAction: TextInputAction.next,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      label: Text("enter your email"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24)),
                    ),
                    validator: (email) {
                      if (email!.isEmpty || !email.contains('@')) {
                        return "enter a valid email";
                      } else {
                        return null;
                      }
                    },
                    textInputAction: TextInputAction.next,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    controller: password,
                    obscureText: viewPassword,
                    decoration: InputDecoration(
                      label: Text("enter your password"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24)),
                    ),
                    validator: (password) {
                      if (password!.isEmpty || password.length < 5) {
                        return "enter a valid email";
                      } else {
                        return null;
                      }
                    },
                    textInputAction: TextInputAction.next,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextFormField(
                    controller: Conformpassword,
                    obscureText: viewPassword,
                    decoration: InputDecoration(
                      label: Text("conform your password"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24)),
                    ),
                    // ignore: non_constant_identifier_names
                    validator: (Conformpassword) {
                      if (Conformpassword!.isEmpty ||
                          Conformpassword.length < 5) {
                        return "enter a the same password";
                      } else {
                        return null;
                      }
                    },
                    textInputAction: TextInputAction.next,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)))),
                      onPressed: () {
                        //logindata.setBool('login', false);

                        final validate = formkey.currentState!.validate();
                        if (validate && password.text == Conformpassword.text) {
                          addItem();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Sucess()));
                        } else {
                          Fluttertoast.showToast(
                              msg: "enter valid details",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              // timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      },
                      child: Text('Submit')),
                ),
                SizedBox(
                  height: 5,
                ),
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      "OR",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)))),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text('Login')),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
