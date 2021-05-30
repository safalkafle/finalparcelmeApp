import 'package:flutter/material.dart';
import 'package:parcelme/pages/aboutus.dart';
import 'package:parcelme/pages/changeInfo.dart';
import 'package:parcelme/pages/changePassword.dart';
import 'package:parcelme/pages/profile.dart';

import 'home.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Menu',
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.white,
      ),

      // Satrting of body
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Card(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.amberAccent.withOpacity(0.1),
                gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                  Colors.green,
                  Colors.red,
                  Colors.yellow,
                ])),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileWidget()));
                    },
                    child: Card(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              // Expanded(flex:1,child: Icon(Icons.ac_unit,size: 40,color: Colors.blue, )),
                              Expanded(
                                  flex: 4,
                                  child: Text(
                                    'Profile',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangePassword()));
                    },
                    child: Card(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              //  Expanded(flex:1,child: Icon(Icons.ac_unit,size: 40,color: Colors.blue, )),
                              Expanded(
                                  flex: 4,
                                  child: Text(
                                    'Change Password',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangeInfo()));
                    },
                    child: Card(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              //  Expanded(flex:1,child: Icon(Icons.ac_unit,size: 40,color: Colors.blue, )),
                              Expanded(
                                  flex: 4,
                                  child: Text(
                                    'Change Info',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AboutUs()));
                    },
                    child: Card(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              // Expanded(flex:1,child: Icon(Icons.ac_unit,size: 40,color: Colors.blue, )),
                              Expanded(
                                  flex: 4,
                                  child: Text(
                                    'About us',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ))
                            ],
                          ),
                        ),
                      ),
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
                      Navigator.pop(context);
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
                          "Close",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
