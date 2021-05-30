import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parcelme/config/config.dart';
import 'package:parcelme/pages/completion.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Order extends StatefulWidget {
  final String category;
  final String name;
  final String email;

  final String country;
  final String province;
  final String city;
  final String address;
  final String phone;

  const Order(
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
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  List categories = [];
  String _value;
  final formkey = new GlobalKey<FormState>();
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController countryController = new TextEditingController();
  TextEditingController provinceController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = this.widget.name;
    countryController.text = this.widget.country;
    emailController.text = this.widget.email;
    provinceController.text = this.widget.province;
    cityController.text = this.widget.city;
    addressController.text = this.widget.address;
    phoneController.text = this.widget.phone;
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

  proceed() {
    final form1 = formkey.currentState;
    if (form1.validate() && _value != null) {
      form1.save();
      print(_value);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Completion(
                    category: _value,
                    address: addressController.text,
                    email: emailController.text,
                    city: cityController.text,
                    country: countryController.text,
                    name: nameController.text,
                    phone: phoneController.text,
                    province: provinceController.text,
                  )));
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
          'Order',
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
                            'Choose Parcel Type',
                            style: new TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),

                          DropdownButton(
                            items: categories.map((item) {
                              var index = categories.indexOf(item);

                              return new DropdownMenuItem(
                                child: new Text(item['parcel_type'] +
                                    ' @ Rs.' +
                                    item['parcel_cost'].toString()),
                                value: item['parcel_catagory_id'].toString() +
                                    '-' +
                                    index.toString(),
                              );
                            }).toList(),
                            onChanged: (newVal) {
                              setState(() {
                                _value = newVal;
                              });
                            },
                            value: _value,
                            hint: Text('Select Item'),
                          ),

                          Text(
                            'Deliver To',
                            style: new TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 60),
                            child: TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                hintText: "Name",
                                hintStyle: TextStyle(color: Colors.blue),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Name  ';
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
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: "Email",
                                hintStyle: TextStyle(color: Colors.blue),
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
                              controller: countryController,
                              decoration: InputDecoration(
                                hintText: "Country",
                                hintStyle: TextStyle(color: Colors.blue),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Country  ';
                                }
                                return null;
                              },
                            ),
                          ),
                          //Section for Provience
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 60),
                            child: TextFormField(
                              controller: provinceController,
                              decoration: InputDecoration(
                                hintText: "Provience",
                                hintStyle: TextStyle(color: Colors.blue),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Province  ';
                                }
                                return null;
                              },
                            ),
                          ),
                          // section for city
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 60),
                            child: TextFormField(
                              controller: cityController,
                              decoration: InputDecoration(
                                hintText: "City",
                                hintStyle: TextStyle(color: Colors.blue),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter City  ';
                                }
                                return null;
                              },
                            ),
                          ),
                          // Section for Address
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 60),
                            child: TextFormField(
                              controller: addressController,
                              decoration: InputDecoration(
                                hintText: "Address",
                                hintStyle: TextStyle(color: Colors.blue),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Address  ';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          // Section for Phone number
                          Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 60),
                            child: TextFormField(
                              controller: phoneController,
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
