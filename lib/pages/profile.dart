import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:parcelme/Helper/auth.dart';
import 'package:parcelme/pages/changeInfo.dart';

class ProfileWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  ProfileWidget({Key key, this.parentScaffoldKey}) : super(key: key);
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  var profile;
  bool load = false;
  @override
  void initState() {
    //load at the first
    super.initState();
    // checklogin(context);
    fetchUserDetail();
  }

  fetchUserDetail() async {
    var profile1 = json.decode(await getUser());

    setState(() {
      profile = profile1;
      load = true;
    });
    print(profile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(
              letterSpacing: 1.3, color: Theme.of(context).primaryColor)),
        ),
        actions: <Widget>[
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChangeInfo()));
              },
              child: new Icon(Icons.edit)),
        ],
      ),
      body: load
          ? SingleChildScrollView(
//              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 160,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(300)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).focusColor,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(30)),
                                  ),
                                  child: CachedNetworkImage(
                                    height: 135,
                                    width: 135,
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        'https://www.shareicon.net/data/512x512/2016/08/05/806962_user_512x512.png',
                                    placeholder: (context, url) => Image.asset(
                                      'assets/images/loading.gif',
                                      fit: BoxFit.cover,
                                      height: 135,
                                      width: 135,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset('assets/images/avatar.png'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          profile['users_name'],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          profile['users_email'],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    leading: Icon(
                      Icons.person,
                      color: Theme.of(context).hintColor,
                    ),
                    title: Text(
                      'About',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, bottom: 10, left: 30),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              'User Country',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            )),
                        Expanded(
                            flex: 3,
                            child: Text(
                              profile['users_country'],
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue),
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, bottom: 10, left: 30),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              'User Province',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            )),
                        Expanded(
                            flex: 3,
                            child: Text(
                              profile['users_province'],
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue),
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, bottom: 10, left: 30),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              'User District',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            )),
                        Expanded(
                            flex: 3,
                            child: Text(
                              profile['users_district'],
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue),
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, bottom: 10, left: 30),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              'User Address',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            )),
                        Expanded(
                            flex: 3,
                            child: Text(
                              profile['users_address'],
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue),
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, bottom: 10, left: 30),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              'User Phone',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            )),
                        Expanded(
                            flex: 3,
                            child: Text(
                              profile['users_phone'],
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
