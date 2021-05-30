import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parcelme/Helper/auth.dart';
import 'package:parcelme/config/config.dart';
import 'package:parcelme/pages/home.dart';
import 'package:parcelme/pages/info.dart';
import 'package:parcelme/pages/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  void initState() {
    //load at the first
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'About Us',
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Colors.white,
              Colors.white,
              Colors.white,
            ])),
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
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Parcelme is not just a mobile application featuring the end-users. It’s a way you choose to get your parcel delivered. With one price for delivering your parcel to the place you want. We take our customers on high grounds and your satisfaction is what we want.",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "If there are any suggestions or any complaints feel free to contact us:",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text(
                            'Phone: ',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          )),
                      Expanded(
                          flex: 3,
                          child: Text(
                            '9860905133',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Text(
                            'Email: ',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          )),
                      Expanded(
                          flex: 3,
                          child: Text(
                            'customer@parcelme.com.np',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
