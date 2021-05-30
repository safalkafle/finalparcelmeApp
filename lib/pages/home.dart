import 'package:flutter/material.dart';
import 'package:parcelme/Helper/auth.dart';
import 'package:parcelme/pages/history.dart';
import 'package:parcelme/pages/menu.dart';
import 'package:parcelme/pages/order.dart';
import 'package:parcelme/pages/trackorder.dart';

class HomeState extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        leading: GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Menu()));
            },
            child: const Icon(Icons.menu)),
        actions: [
          GestureDetector(
            child: Icon(Icons.logout),
            onTap: () {
              logout(context);
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Order()));
        },
        label: const Text('Order Now'),
        icon: const Icon(Icons.add_circle_outline_sharp),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // this is single card for the app
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                elevation: 4,
                child: SizedBox(
                  height: 296,
                  //color: Colors.blueGrey,
                  child: Container(
                    color: Color(0xf5f5f5),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 200,
                            //child: Icon(Icons.search),
                            child: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Image.network(
                                  "https://icon-library.com/images/history_o_1187026.png"),
                            ),
                          ),
                          FlatButton(
                            onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => History()))
                            },
                            color: Colors.blue,
                            textColor: Colors.white,
                            child: SizedBox(
                                width: double.infinity,
                                height: 64,
                                child: Center(child: Text('History'))),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // this is single card for the app
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                elevation: 4,
                child: SizedBox(
                  height: 296,
                  //color: Colors.blueGrey,
                  child: Container(
                    color: Color(0xf5f5f5),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 200,
                            //child: Icon(Icons.search),
                            child: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Image.network(
                                  "https://parcelment.com/wp-content/uploads/2016/09/parcel.png"),
                            ),
                          ),
                          FlatButton(
                            onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TrackOrder()))
                            },
                            color: Colors.blue,
                            textColor: Colors.white,
                            child: SizedBox(
                                width: double.infinity,
                                height: 64,
                                child: Center(child: Text('Track Parcel'))),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
