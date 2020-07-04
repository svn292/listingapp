import 'dart:convert';
import 'dart:io' show Platform;

import 'package:daangor/config/ui_icons.dart';
import 'package:daangor/src/providers/data_provider.dart';
import 'package:daangor/src/util/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SignInWidget extends StatefulWidget {
  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  RegExp emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  bool _isLoading = false;
  bool _showPassword = false;
  TextEditingController _txtEmail = TextEditingController();
  TextEditingController _txtPassword = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: SingleChildScrollView(
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
                          BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.2), offset: Offset(0, 10), blurRadius: 20)
                        ]),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 25),
                        Text('Sign In', style: Theme.of(context).textTheme.display2),
                        SizedBox(height: 20),
                        new TextField(
                          controller: _txtEmail,
                          style: TextStyle(color: Theme.of(context).focusColor),
                          keyboardType: TextInputType.emailAddress,
                          decoration: new InputDecoration(
                            hintText: 'Email Address',
                            hintStyle: Theme.of(context).textTheme.body1.merge(
                                  TextStyle(color: Theme.of(context).focusColor.withOpacity(0.6)),
                                ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor)),
                            prefixIcon: Icon(
                              UiIcons.envelope,
                              color: Theme.of(context).focusColor.withOpacity(0.6),
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
                                  TextStyle(color: Theme.of(context).focusColor.withOpacity(0.6)),
                                ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor)),
                            prefixIcon: Icon(
                              UiIcons.padlock_1,
                              color: Theme.of(context).focusColor.withOpacity(0.6),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                              color: Theme.of(context).focusColor.withOpacity(0.4),
                              icon: Icon(_showPassword ? Icons.visibility_off : Icons.visibility),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        FlatButton(
                          onPressed: () async {
                            const url = 'http://daangor.com/home/forgot_password';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Text(
                            'Forgot your password ?',
                            style: Theme.of(context).textTheme.body1,
                          ),
                        ),
                        SizedBox(height: 30),
                        FlatButton(
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 70),
                          onPressed: () {
                            if (validation()) {
                              setState(() {
                                _isLoading = true;
                              });
                              loginProcess();
                            }
                          },
                          child: Text(
                            'Login',
                            style: Theme.of(context).textTheme.title.merge(
                                  TextStyle(color: Theme.of(context).primaryColor),
                                ),
                          ),
                          color: Theme.of(context).accentColor,
                          //  color: Color,
                          shape: StadiumBorder(),
                        ),
                        SizedBox(height: 20),
                        // Text(
                        //   'Or using social media',
                        //   style: Theme.of(context).textTheme.body1,
                        // ),
                        // SizedBox(height: 20),
                        // new SocialMediaWidget(),
                      ],
                    ),
                  ),
                ],
              ),
              //  SizedBox(height: 20),
              FlatButton(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 70),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/Tabs', arguments: 0);
                },
                child: Text(
                  'SKIP',
                  style: Theme.of(context).textTheme.title.merge(
                        TextStyle(color: Theme.of(context).primaryColor),
                      ),
                ),
                color: Color.fromRGBO(55, 169, 157, 1),
                shape: StadiumBorder(),
              ),
              SizedBox(height: 20),

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
                      TextSpan(text: ' Sign Up', style: TextStyle(fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(String message) {
    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // title: Text("My title"),
            content: Text(message),
            actions: [
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    } else if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            // title: Text("My title"),
            content: Text(message),
            actions: [
              CupertinoButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  bool validation() {
    if (_txtEmail.text.isEmpty) {
      showAlertDialog('Please enter Email id');
      return false;
    } else if (!emailValid.hasMatch(_txtEmail.text)) {
      showAlertDialog('Please enter valid email');
      return false;
    } else if (_txtPassword.text.isEmpty) {
      showAlertDialog('Please enter password');
      return false;
    }

    return true;
  }

  loginProcess() async {
    print("sign in API calls");
    Map<String, String> body = Map();
    var url = "$BASEURL/login";
    body["email"] = _txtEmail.text;
    body["password"] = _txtPassword.text;
    // try {
    FormData formData = new FormData.fromMap(body);
    var response = await Dio().post(url, data: formData);
    print(response.data + "    :   LOGINNNNNNNNNNNNNNNn");

    if (jsonDecode(response.data)['login'] == 'true') {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', jsonDecode(response.data)['user']['token']);
      setState(() {
        Provider.of<DataProvider>(context, listen: false).userToken = TOKEN;
        TOKEN = jsonDecode(response.data)['user']['token'];
      });
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pushReplacementNamed('/Tabs', arguments: 0);
    } else {
      setState(() {
        _isLoading = false;
      });
      // Fluttertoast.showToast(
      //     msg: jsonDecode(response.data)['msg'],
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIos: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0);

      showAlertDialog(jsonDecode(response.data)['msg']);
    }
    // } catch (e) {
    //   Fluttertoast.showToast(
    //       msg: "LOGIN ERROR",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.BOTTOM,
    //       timeInSecForIos: 1,
    //       backgroundColor: Colors.red,
    //       textColor: Colors.white,
    //       fontSize: 16.0);
    // }
  }
}
