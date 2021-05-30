import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parcelme/Helper/auth.dart';
import 'package:parcelme/config/config.dart';
import 'package:parcelme/pages/completion.dart';
import 'package:parcelme/pages/home.dart';
import 'package:parcelme/pages/success.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Completion extends StatefulWidget {
  final String category;
  final String name;
  final String email;

  final String country;
  final String province;
  final String city;
  final String address;
  final String phone;

  const Completion(
      {Key key,
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
  _CompletionState createState() => _CompletionState();
}

class _CompletionState extends State<Completion> {
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

  proceed() async {
    final form1 = formkey.currentState;
    if (form1.validate() && _value != null) {
      form1.save();
      var token = await getToken();
      final url = API_URL + 'parcelAdd';
      var requestBody = {
        "delivery_email": this.widget.email,
        "category_id": this.widget.category.split("-")[0],
        "receiver_name": this.widget.name,
        "delivery_country": this.widget.country,
        "delivery_province": this.widget.province,
        "delivery_zone": '0',
        "delivery_address": this.widget.address,
        "delivery_phone": this.widget.phone,
        "delivery_district": this.widget.city,
        "token": token
      };
      print(requestBody);
      http.Response response = await http.post(url, body: requestBody);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var responseJson = json.decode(response.body);
      print(response.body);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Request Submitted Successfully.')),
        );
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SplashScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Request Could not be submitted')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all form data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Order Completion',
          style: TextStyle(color: Colors.white),
        ),
      ),

      // Satrting of body
      body: SingleChildScrollView(
        child: Padding(
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
                                    'RS ' +
                                        categories[int.parse(this
                                                .widget
                                                .category
                                                .split("-")[1])]['parcel_cost']
                                            .toString(),
                                    style: new TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                          ),
                          // DropdownButton(
                          //   items: categories.map((item) {
                          //     var index = categories.indexOf(item);
                          //     return new DropdownMenuItem(
                          //       child: new Text(item['parcel_type'] +
                          //           ' @ Rs.' +
                          //           item['parcel_cost'].toString()),
                          //       value: item['parcel_catagory_id'].toString() +
                          //           '-' +
                          //           index.toString(),
                          //     );
                          //   }).toList(),
                          //   onChanged: (newVal) {
                          //     setState(() {
                          //       _value = newVal;
                          //     });
                          //   },
                          //   value: _value,
                          //   hint: Text('Select Item'),
                          // ),

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
                              initialValue: this.widget.phone,
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
                                proceed();
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
                          SizedBox(
                            height: 20.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeState()));
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
                                    "Cancel",
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
      ),
    );
  }
}
