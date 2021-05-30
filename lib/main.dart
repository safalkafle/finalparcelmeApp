import 'package:flutter/material.dart';
import 'package:parcelme/pages/completion.dart';
import 'package:parcelme/pages/login.dart';
import 'package:parcelme/pages/home.dart';
import 'package:parcelme/pages/signup.dart';
import 'package:parcelme/pages/order.dart';
import 'package:parcelme/pages/info.dart';
import 'package:parcelme/pages/completion.dart';
import 'package:parcelme/pages/success.dart';
import 'package:parcelme/pages/menu.dart';
import 'package:parcelme/pages/history.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
    );

}
}
