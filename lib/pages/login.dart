import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parcelme/Helper/auth.dart';
import 'package:parcelme/config/config.dart';
import 'package:parcelme/pages/home.dart';
import 'package:parcelme/pages/info.dart';
import 'package:parcelme/pages/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    //load at the first
    super.initState();
    checklogin(context);
  }

  final formkey = new GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  login() async {
    final url = API_URL + 'userlogin';
    if (validateform()) {
      var requestBody = {
        "users_email": emailController.text,
        "users_password": passwordController.text,
      };
      http.Response response = await http.post(url, body: requestBody);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var responseJson = json.decode(response.body);
      print(response.body);
      if (response.statusCode == 200) {
        prefs.setString('user_token', responseJson['token']);
        prefs.setString('user_detail', json.encode(responseJson['data']));
        print(response.body);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login Successful.')),
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Info()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could Not Register')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please complete form'),
      ));
      print('Please complete form');
    }
  }

  bool validateform() {
    final form1 = formkey.currentState;
    if (form1.validate()) {
      form1.save();
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.white,
            Colors.white,
            Colors.white,
          ])),
          child: Form(
            key: formkey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                  width: double.infinity,
                ),
                Container(
                  color: Colors.black,
                  child: Image(
                      image: AssetImage('assets/images/parcelme.png'),
                      height: 100,
                      width: 100),
                ),

                Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 60),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Email Address",
                      hintStyle: TextStyle(color: Colors.blue),
                      suffixIcon: Icon(
                        Icons.email,
                        color: Colors.blue,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Email  ';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),

                Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 60),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.blue),
                      suffixIcon: Icon(Icons.lock),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Password  ';
                      }
                      return null;
                    },
                  ),
                ),
                // Login Section
                SizedBox(
                  height: 20.0,
                ),

                GestureDetector(
                  onTap: () {
                    login();
                  },
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 60),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),

                // Signup section
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Text("New Here?"),
                ),
                SizedBox(
                  height: 20.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Signup()));
                  },
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 60),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
