import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parcelme/Helper/auth.dart';
import 'package:parcelme/config/config.dart';
import 'package:parcelme/pages/completion.dart';
import 'package:parcelme/pages/home.dart';
import 'package:parcelme/pages/success.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class historyDetail extends StatefulWidget {
  final String category;
  final String name;
  final String email;
  final String cost;
  final String country;
  final String province;
  final String city;
  final String address;
  final String phone;

  const historyDetail(
      {Key key,
      this.cost,
      this.category,
      this.name,
      this.email,
      this.country,
      this.province,
      this.city,
      this.address,
      this.phone})
      : super(key: key);
  @override
  _historyDetailState createState() => _historyDetailState();
}

class _historyDetailState extends State<historyDetail> {
  List categories = [];
  String _value;
  final formkey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    print(this.widget.category);
    this.widget.category != null ? _value = this.widget.category : null;
    getAllCategory();
  }

  getAllCategory() async {
    final url = API_URL + 'ptype/all';
    http.Response response = await http.get(url);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var responseJson = json.decode(response.body);
    print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        categories = responseJson;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could Not Fetch Data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Order Detail',
          style: TextStyle(color: Colors.white),
        ),
      ),

      // Satrting of body
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: categories.length > 0
            ? Card(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient:
                          LinearGradient(begin: Alignment.topCenter, colors: [
                    Colors.white,
                    Colors.white,
                    Colors.white,
                  ])),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: <Widget>[
                        //Section for Country Name
                        Text(
                          'Order Details',
                          style: new TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                              decoration: new BoxDecoration(
                                  color: Colors.amberAccent.withOpacity(0.5)),
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Text(
                                  'For ' +
                                      this.widget.category +
                                      ' @ RS ' +
                                      this.widget.cost,
                                  style: new TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                        ),

                        Text(
                          'Deliver To',
                          style: new TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
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
                            initialValue: this.widget.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Name';
                              }
                              return null;
                            },
                            enabled: false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Name",
                              hintStyle: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),

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
                            initialValue: this.widget.email,
                            enabled: false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.blue),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Email';
                              }
                              return null;
                            },
                          ),
                        ),

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
                            initialValue: this.widget.country,
                            enabled: false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Country",
                              hintStyle: TextStyle(color: Colors.blue),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Country';
                              }
                              return null;
                            },
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
                            initialValue: this.widget.province,
                            enabled: false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Provience",
                              hintStyle: TextStyle(color: Colors.blue),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Province';
                              }
                              return null;
                            },
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
                            initialValue: this.widget.city,
                            enabled: false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "City",
                              hintStyle: TextStyle(color: Colors.blue),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter City';
                              }
                              return null;
                            },
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
                            initialValue: this.widget.address,
                            enabled: false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Address",
                              hintStyle: TextStyle(color: Colors.blue),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Address';
                              }
                              return null;
                            },
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
                            initialValue: this.widget.phone.toString(),
                            enabled: false,
                            decoration: InputDecoration(
                              hintText: "Phone number",
                              hintStyle: TextStyle(color: Colors.blue),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Phone  ';
                              }
                              return null;
                            },
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
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 60),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.redAccent,
                              ),
                              child: Center(
                                child: Text(
                                  "Go Back",
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
                ),
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
