import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:parcelme/Helper/auth.dart';
import 'package:parcelme/config/config.dart';
import 'package:http/http.dart' as http;
import 'package:parcelme/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  final formkey = new GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController countryController = new TextEditingController();
  TextEditingController provinceController = new TextEditingController();
  TextEditingController districtController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  @override
  void initState() {
    //load at the first
    super.initState();
    checkinfo(context);
    // checklogin(context);
  }

  registerAddress() async {
    var token = await getToken();
    final url = API_URL + 'userRegister2';
    if (validateform()) {
      var requestBody = {
        "users_country": countryController.text,
        "users_province": provinceController.text,
        "users_district": districtController.text,
        "users_address": addressController.text,
        "users_phone": phoneController.text,
        "token": token
      };
      http.Response response = await http.post(
        url,
        body: requestBody,
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(response.body);

      var responseJson = json.decode(response.body);
      if (response.statusCode == 200) {
        prefs.setString('user_token', responseJson['token']);
        prefs.setString('user_detail', json.encode(responseJson['data']));
        print(response.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Registration Completion Successful. Continue with Further Details'),
        ));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeState()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar((SnackBar(content: Text('Could Not Register'))));
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
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Personal Info',
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.arrow_back_ios_sharp,
          color: Colors.blue,
        ), //leading back space icon
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
                    //Section for Country Name
                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 60),
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                          color: Colors.blue[100],
                        )),
                      ),
                      child: TextFormField(
                        controller: countryController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Country",
                          hintStyle: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    //Section for Provience
                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 60),
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                          color: Colors.blue[100],
                        )),
                      ),
                      child: TextFormField(
                        controller: provinceController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Province",
                          hintStyle: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    // section for city
                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 60),
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                          color: Colors.blue[100],
                        )),
                      ),
                      child: TextFormField(
                        controller: districtController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "District",
                          hintStyle: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    // Section for Address
                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 60),
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                          color: Colors.blue[100],
                        )),
                      ),
                      child: TextFormField(
                        controller: addressController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Address",
                          hintStyle: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),

                    // Section for Phone number
                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 60),
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                          color: Colors.blue[100],
                        )),
                      ),
                      child: TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Phone number",
                          hintStyle: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),

                    // Proceed buttons button
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          registerAddress();
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
                              "Proceed",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
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
