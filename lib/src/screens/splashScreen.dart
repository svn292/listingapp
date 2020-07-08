import 'dart:convert';

import 'package:daangor/src/models/city_model.dart';
import 'package:daangor/src/providers/data_provider.dart';
import 'package:daangor/src/screens/signin.dart';
import 'package:daangor/src/screens/tabs.dart';
import 'package:daangor/src/util/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

    TOKEN = prefs.getString('token');
    if (TOKEN != null && TOKEN != "") {
      Dio dio = Dio();
      // if (TOKEN != null && TOKEN != "") {
      dio.options.headers["authorization"] = TOKEN;
      var url = "$BASEURL/tokenvalidity";
      var userresponse = await dio.get(url);
      print(userresponse.data + "    KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");

      if (userresponse.data == '["true"]') {
        setState(() {
          tokenAvailability = true;
        });
      }
      // }
    } else
      setState(() {
        tokenAvailability = false;
        TOKEN = '';
      });
// final myString = prefs.getString('my_string_key') ?? '';
  }

  @override
  void initState() {
    getTokenAvailability();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initiateCityModel();
    return SplashScreen(
      seconds: 8,
      navigateAfterSeconds: tokenAvailability
          ? TabsWidget(
              currentTab: 0,
            )
          : SignInWidget(),
      title: Text(
        'Assam 1st Business Listing',
        textAlign: TextAlign.center,
        style: TextStyle(
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

  initiateCityModel() async {
    var prefs = await SharedPreferences.getInstance();

    var cityModel = CityModel.fromJson(json.decode(prefs.getString('set_city')));

    if (cityModel != null) {
      context.read<DataProvider>().changeCityModel(cityModel);
    }
  }
}
