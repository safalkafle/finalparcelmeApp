import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parcelme/Helper/auth.dart';
import 'package:parcelme/config/config.dart';
import 'package:http/http.dart' as http;
import 'package:parcelme/pages/historyDetail.dart';
import 'home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List orders = [];
  @override
  void initState() {
    super.initState();
    getAllOrders();
  }

  getAllOrders() async {
    final url = API_URL + 'parcelHistory';
    var token = await getToken();
    http.Response response = await http.post(url, body: {"token": token});
    var responseJson = json.decode(response.body);
    print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        orders = responseJson;
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
          'History',
          style: TextStyle(color: Colors.white),
        ),
      ),

      // Satrting of body
      body: orders.length > 0
          ? Padding(
              padding: const EdgeInsets.all(25.0),
              child: Card(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.amberAccent.withOpacity(0.1),
                      gradient:
                          LinearGradient(begin: Alignment.topCenter, colors: [
                        Colors.green,
                        Colors.red,
                        Colors.yellow,
                      ])),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                          itemCount: orders.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeState()));
                                },
                                child: Card(
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    flex: 2,
                                                    child: Text(
                                                      'Order Id',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.blue),
                                                    )),
                                                Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      orders[index]['order_id']
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                                      'Receiver Name',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.blue),
                                                    )),
                                                Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      orders[index]
                                                              ['receiver_name']
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                                      'Delivery Address',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.blue),
                                                    )),
                                                Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      orders[index][
                                                              'delivery_address']
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                                      'Delivery Phone',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.blue),
                                                    )),
                                                Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      orders[index]
                                                              ['delivery_phone']
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                                      'Delivery Email',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.blue),
                                                    )),
                                                Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      orders[index]
                                                              ['delivery_email']
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.blue),
                                                    ))
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            historyDetail(
                                                              category: orders[
                                                                      index][
                                                                  'parcel_type'],
                                                              cost: orders[
                                                                          index]
                                                                      [
                                                                      'parcel_cost']
                                                                  .toString(),
                                                              address: orders[
                                                                      index][
                                                                  'delivery_address'],
                                                              email: orders[
                                                                      index][
                                                                  'delivery_email'],
                                                              city: orders[
                                                                      index][
                                                                  'delivery_district'],
                                                              country: orders[
                                                                      index][
                                                                  'delivery_country'],
                                                              name: orders[
                                                                      index][
                                                                  'receiver_name'],
                                                              phone: orders[
                                                                          index]
                                                                      [
                                                                      'delivery_phone']
                                                                  .toString(),
                                                              province: orders[
                                                                      index][
                                                                  'delivery_province'],
                                                            )));
                                              },
                                              child: Container(
                                                height: 30,
                                                // margin: EdgeInsets.symmetric(horizontal: 30),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.blue,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Detail",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
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
                              ),
                            );
                          },
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
                            // execute code for go to home by keeping a widget gesture dectector
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 60),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.blue,
                            ),
                            child: Center(
                              child: Text(
                                "Go to home",
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
    );
  }
}
