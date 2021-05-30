import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parcelme/Helper/auth.dart';
import 'package:parcelme/config/config.dart';
import 'package:parcelme/pages/home.dart';
import 'package:parcelme/pages/info.dart';
import 'package:parcelme/pages/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  void initState() {
    //load at the first
    super.initState();
  }

  final formkey = new GlobalKey<FormState>();
  TextEditingController oldController = new TextEditingController();
  TextEditingController confirmController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  changePass() async {
    final url = API_URL + 'changePass';
    var token = await getToken();

    if (validateform() && passwordController.text == confirmController.text) {
      var requestBody = {
        "oldPass": oldController.text,
        "users_password": passwordController.text,
        "token": token
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
          SnackBar(content: Text('Password Changed Successfully')),
        );
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeState()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could Not Change Password')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please complete form or check confirm password'),
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
          'Change Password',
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
                    controller: oldController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Enter Old Password",
                      hintStyle: TextStyle(color: Colors.blue),
                      suffixIcon: Icon(
                        Icons.history,
                        color: Colors.blue,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Old Password  ';
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
                Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 60),
                  child: TextFormField(
                    controller: confirmController,
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
                // Login Section
                SizedBox(
                  height: 20.0,
                ),
                GestureDetector(
                  onTap: () {
                    changePass();
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
                        "Change Password",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
