import 'dart:convert';

import 'package:daangor/src/screens/signin.dart';
import 'package:daangor/src/screens/tabs.dart';
import 'package:daangor/src/util/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:daangor/src/screens/on_boarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool tokenAvailability = false;
  getTokenAvailability() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') != null && prefs.getString('token') != "") {
      Dio dio = Dio();
      // if (TOKEN != null && TOKEN != "") {
        dio.options.headers["authorization"] = prefs.getString('token');
        var url = "$BASEURL/tokenvalidity";
        var userresponse = await dio.get(url);
        print(userresponse.data +"    KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");

        if (userresponse.data == '["true"]') {
          setState(() {
            tokenAvailability = true;
          });
        }
      // }
    }
// final myString = prefs.getString('my_string_key') ?? '';
  }

  @override
  void initState() {
    getTokenAvailability();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 8,
      navigateAfterSeconds: tokenAvailability
          ? TabsWidget(
              currentTab: 0,
            )
          : SignInWidget(),
      title: new Text(
        'Assam 1st Business Listing',
        textAlign: TextAlign.center,
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25.0,
          color: Color.fromRGBO(104, 61, 146, 1),
        ),
      ),
      photoSize: MediaQuery.of(context).size.width * 0.4,
      image: Image.asset(
        "img/dark_logo.png",
      ),
      backgroundColor: Colors.white,
      // backgroundColor: Theme.of(context).accentColor.withOpacity(0.7),
      loaderColor: Color.fromRGBO(104, 61, 146, 1),
    );
  }
}
