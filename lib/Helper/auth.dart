import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parcelme/pages/home.dart';
import 'package:parcelme/pages/info.dart';
import 'package:parcelme/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

checklogin(context) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  if (pref.containsKey('user_token') &&
      pref.get('user_token') != null &&
      pref.containsKey('user_token') &&
      json.decode(pref.get('user_detail'))['users_country'] != null) {
    print('is Logged in');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeState()));
  } else {
    if (pref.containsKey('user_token') &&
        pref.get('user_token') != null &&
        pref.containsKey('user_token') &&
        json.decode(pref.get('user_detail'))['users_country'] == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Info()));
    }
    print('Is not logged in');
  } //funtion is used to check if the token is available or not in the system . if logged in navigates to Homepage else stays in Login page.
}

checkinfo(context) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  if (pref.containsKey('user_token') &&
      pref.get('user_token') != null &&
      pref.containsKey('user_token') &&
      json.decode(pref.get('user_detail'))['users_country'] != null) {
    print('is Logged in');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeState()));
  } else {
    return false;
  } //funtion is used to check if the token is available or not in the system . if logged in navigates to Homepage else stays in Login page.
}

Future<String> logout(context) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.remove('user_detail');
  pref.remove('user_token');
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => Login()));
}

Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.get('user_token');
}

Future<String> getUser() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.get('user_detail');
}
