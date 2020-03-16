import 'dart:convert';

import 'package:daangor/config/ui_icons.dart';
import 'package:daangor/src/util/constants.dart';
import 'package:daangor/src/widgets/SocialMediaWidget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignInWidget extends StatefulWidget {
  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  bool _showPassword = false;
  TextEditingController _txtEmail = TextEditingController();
  TextEditingController _txtPassword = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  margin: EdgeInsets.symmetric(vertical: 65, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).primaryColor,
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).hintColor.withOpacity(0.2),
                            offset: Offset(0, 10),
                            blurRadius: 20)
                      ]),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 25),
                      Text('Sign In',
                          style: Theme.of(context).textTheme.display2),
                      SizedBox(height: 20),
                      new TextField(
                        controller: _txtEmail,
                        style: TextStyle(color: Theme.of(context).focusColor),
                        keyboardType: TextInputType.emailAddress,
                        decoration: new InputDecoration(
                          hintText: 'Email Address',
                          hintStyle: Theme.of(context).textTheme.body1.merge(
                                TextStyle(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.6)),
                              ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).focusColor)),
                          prefixIcon: Icon(
                            UiIcons.envelope,
                            color:
                                Theme.of(context).focusColor.withOpacity(0.6),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      new TextField(
                        controller: _txtPassword,
                        style: TextStyle(color: Theme.of(context).focusColor),
                        keyboardType: TextInputType.text,
                        obscureText: !_showPassword,
                        decoration: new InputDecoration(
                          hintText: 'Password',
                          hintStyle: Theme.of(context).textTheme.body1.merge(
                                TextStyle(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.6)),
                              ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).focusColor)),
                          prefixIcon: Icon(
                            UiIcons.padlock_1,
                            color:
                                Theme.of(context).focusColor.withOpacity(0.6),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            color:
                                Theme.of(context).focusColor.withOpacity(0.4),
                            icon: Icon(_showPassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      FlatButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot your password ?',
                          style: Theme.of(context).textTheme.body1,
                        ),
                      ),
                      SizedBox(height: 30),
                      FlatButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 70),
                        onPressed: () async {
                          Map<String, String> body = Map();
                          var url = "$BASEURL/login";
                          body["email"] = _txtEmail.text;
                          body["password"] = _txtPassword.text;
                          try {
                            FormData formData = new FormData.fromMap(body);
                            var response =
                                await Dio().post(url, data: formData);
                            print(jsonDecode(response.data)['login'] +
                                "    :   LOGINNNNNNNNNNNNNNNn");
                            if (jsonDecode(response.data)['login'] == 'true') {
                              Navigator.of(context)
                                  .pushNamed('/Tabs', arguments: 2);
                            } else {
                              Fluttertoast.showToast(
                                  msg: "LOGIN ERROR",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIos: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          } catch (e) {
                            Fluttertoast.showToast(
                                msg: "LOGIN ERROR",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIos: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        child: Text(
                          'Login',
                          style: Theme.of(context).textTheme.title.merge(
                                TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                        ),
                        color: Theme.of(context).accentColor,
                        shape: StadiumBorder(),
                      ),
                      SizedBox(height: 50),
                      Text(
                        'Or using social media',
                        style: Theme.of(context).textTheme.body1,
                      ),
                      SizedBox(height: 20),
                      new SocialMediaWidget()
                    ],
                  ),
                ),
              ],
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/SignUp');
              },
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.title.merge(
                        TextStyle(color: Theme.of(context).primaryColor),
                      ),
                  children: [
                    TextSpan(text: 'Don\'t have an account ?'),
                    TextSpan(
                        text: ' Sign Up',
                        style: TextStyle(fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
