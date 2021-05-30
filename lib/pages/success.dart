import 'dart:async';
import 'package:flutter/material.dart';
import 'home.dart';

// ignore: must_be_immutable
class SplashScreen extends StatefulWidget {

  @override
  SplashScreen();

  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  startTime() async{
    var _duration=new Duration(seconds: 5);
    return Timer(_duration, navigationPage);
  }

  void navigationPage(){
    Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeState()));
  }

  @override
  void initState(){
    super.initState();
    startTime();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit:StackFit.expand,
        children: <Widget>[

          SafeArea( child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Order Successful', style: TextStyle(color: Colors.grey, height: 5.0,fontSize: 30),),

              Image.asset(
                'assets/images/check.png',
                height: 250,
                width: 320,
              ),
              Center(child: Text('Thank you for choosing us, We you will receive a call from our representative soon.',maxLines: 3,overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.grey, height: 3.0,fontSize: 20),))

            ],
          ),
          ),
        ],
      ),

    );
  }
}