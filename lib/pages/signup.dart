import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parcelme/Helper/auth.dart';
import 'package:parcelme/config/config.dart';
import 'package:parcelme/pages/home.dart';
import 'package:parcelme/pages/info.dart';
import 'package:parcelme/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final formkey = new GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController fullNameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPassController = new TextEditingController();

  @override
  void initState() {
    //load at the first
    super.initState();
    checklogin(context);
  }

  register() async {
    final url = API_URL + 'userRegister';
    if (validateform() &&
        passwordController.text == confirmPassController.text) {
      var requestBody = {
        "users_email": emailController.text,
        "users_password": passwordController.text,
        "users_name": fullNameController.text,
      };
      http.Response response = await http.post(url, body: requestBody);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var responseJson = json.decode(response.body);
      if (response.statusCode == 200) {
        prefs.setString('user_token', responseJson['token']);
        prefs.setString('user_detail', json.encode(responseJson['data']));

        print(response.body);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Registration Completion Successful. Continue with Further Details')),
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
          'Signup',
          style: TextStyle(color: Colors.blue),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        //leading back space icon
      ),
      // completion of app bar

      // Starting body section

      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.white,
            Colors.white,
            Colors.white,
          ])),
          child: Column(
            children: [
              Image.asset(
                'assets/images/Mobile-Register.jpg',
                height: 250,
                width: 320,
              ),
              Form(
                key: formkey,
                child: Column(
                  children: <Widget>[
                    //Section for Full name
                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 60),
                      child: TextFormField(
                        controller: fullNameController,
                        decoration: InputDecoration(
                          hintText: "Full Name",
                          hintStyle: TextStyle(color: Colors.blue),
                          suffixIcon: Icon(
                            Icons.person,
                            color: Colors.blue,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Name  ';
                          }
                          return null;
                        },
                      ),
                    ),
                    //Section for Email addresss
                    SizedBox(
                      height: 20.0,
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
                    // Section for confirm password
                    SizedBox(
                      height: 20.0,
                    ),

                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 60),
                      child: TextFormField(
                        controller: confirmPassController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          hintStyle: TextStyle(color: Colors.blue),
                          suffixIcon: Icon(Icons.lock),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Confirm Password  ';
                          }
                          return null;
                        },
                      ),
                    ),

                    // Signup buttons button
                    SizedBox(
                      height: 20.0,
                    ),

                    GestureDetector(
                      onTap: () {
                        register();
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
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Center(
                      child: Text("Already Have an Account?"),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Login()));
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
                            "Sign In",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
