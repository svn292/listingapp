import 'dart:convert';
import 'dart:io' show Platform;

import 'package:daangor/config/ui_icons.dart';
import 'package:daangor/src/util/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  RegExp emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  TextEditingController _txtEmail = TextEditingController();
  TextEditingController _txtPassword = TextEditingController();
  TextEditingController _txtConfirmPassword = TextEditingController();
  TextEditingController _txtName = TextEditingController();
  TextEditingController _txtPhone = TextEditingController();
  TextEditingController _txtAddress = TextEditingController();
  bool _showPassword = false;
  bool _isLoading = false;

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
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 25),
                        Text('Sign Up', style: Theme.of(context).textTheme.display2),
                        SizedBox(height: 20),
                        new TextField(
                          controller: _txtEmail,
                          style: TextStyle(color: Theme.of(context).focusColor),
                          keyboardType: TextInputType.emailAddress,
                          decoration: new InputDecoration(
                            hintText: 'Email Address',
                            hintStyle: Theme.of(context).textTheme.body1.merge(
                                  TextStyle(color: Theme.of(context).focusColor.withOpacity(0.4)),
                                ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor)),
                            prefixIcon: Icon(
                              UiIcons.envelope,
                              color: Theme.of(context).focusColor.withOpacity(0.4),
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
                                  TextStyle(color: Theme.of(context).focusColor.withOpacity(0.4)),
                                ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor)),
                            prefixIcon: Icon(
                              UiIcons.padlock_1,
                              color: Theme.of(context).focusColor.withOpacity(0.4),
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
                        new TextField(
                          controller: _txtConfirmPassword,
                          style: TextStyle(color: Theme.of(context).focusColor),
                          keyboardType: TextInputType.text,
                          obscureText: !_showPassword,
                          decoration: new InputDecoration(
                            hintText: 'Confirm Password',
                            hintStyle: Theme.of(context).textTheme.body1.merge(
                                  TextStyle(color: Theme.of(context).focusColor.withOpacity(0.4)),
                                ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor)),
                            prefixIcon: Icon(
                              UiIcons.padlock_1,
                              color: Theme.of(context).focusColor.withOpacity(0.4),
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
                        SizedBox(
                          height: 20,
                        ),
                        new TextField(
                          controller: _txtName,
                          style: TextStyle(color: Theme.of(context).focusColor),
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(
                            hintText: 'Name',
                            hintStyle: Theme.of(context).textTheme.body1.merge(
                                  TextStyle(color: Theme.of(context).focusColor.withOpacity(0.4)),
                                ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor)),
                            prefixIcon: Icon(
                              FontAwesomeIcons.user,
                              color: Theme.of(context).focusColor.withOpacity(0.4),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        new TextField(
                          controller: _txtPhone,
                          style: TextStyle(color: Theme.of(context).focusColor),
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                            hintText: 'Phone Number',
                            hintStyle: Theme.of(context).textTheme.body1.merge(
                                  TextStyle(color: Theme.of(context).focusColor.withOpacity(0.4)),
                                ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor)),
                            prefixIcon: Icon(
                              Icons.phone_android,
                              color: Theme.of(context).focusColor.withOpacity(0.4),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        new TextField(
                          controller: _txtAddress,
                          style: TextStyle(color: Theme.of(context).focusColor),
                          keyboardType: TextInputType.emailAddress,
                          decoration: new InputDecoration(
                            hintText: 'Address',
                            hintStyle: Theme.of(context).textTheme.body1.merge(
                                  TextStyle(color: Theme.of(context).focusColor.withOpacity(0.4)),
                                ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor)),
                            prefixIcon: Icon(
                              FontAwesomeIcons.addressBook,
                              color: Theme.of(context).focusColor.withOpacity(0.4),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(height: 40),
                        FlatButton(
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 70),
                          onPressed: () async {
                            if (validation()) {
                              setState(() {
                                _isLoading = true;
                              });
                              signUpProcess();
                            }
                          },
                          child: Text(
                            'Sign Up',
                            style: Theme.of(context).textTheme.title.merge(
                                  TextStyle(color: Theme.of(context).primaryColor),
                                ),
                          ),
                          color: Theme.of(context).accentColor,
                          shape: StadiumBorder(),
                        ),
                        SizedBox(height: 20),
                        // Text(
                        //   'Or using social media',
                        //   style: Theme.of(context).textTheme.body1,
                        // ),
                        // SizedBox(height: 20),
                        // new SocialMediaWidget()
                      ],
                    ),
                  ),
                ],
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/SignIn');
                },
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.title.merge(
                          TextStyle(color: Theme.of(context).primaryColor),
                        ),
                    children: [
                      TextSpan(text: 'Already have an account ?'),
                      TextSpan(text: ' Sign In', style: TextStyle(fontWeight: FontWeight.w700)),
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

  showAlertDialog(String message, [bool isSignUpSuccess = false]) {
    if (Platform.isAndroid) {
      showDialog(
        barrierDismissible: false,
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
                  if (isSignUpSuccess) {
                    Navigator.of(context).pushReplacementNamed('/SignIn');
                  }
                },
              ),
            ],
          );
        },
      );
    } else if (Platform.isIOS) {
      showCupertinoDialog(
        barrierDismissible: false,
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
                  if (isSignUpSuccess) {
                    Navigator.of(context).pushReplacementNamed('/SignIn');
                  }
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
    } else if (_txtConfirmPassword.text.isEmpty) {
      showAlertDialog('Please enter password');
      return false;
    } else if (_txtConfirmPassword.text != _txtPassword.text) {
      showAlertDialog('Please enter same password');
      return false;
    } else if (_txtName.text.isEmpty) {
      showAlertDialog('Please enter name');
      return false;
    } else if (_txtPhone.text.isEmpty) {
      showAlertDialog('Please enter phone number');
      return false;
    } else if (_txtAddress.text.isEmpty) {
      showAlertDialog('Please enter address');
      return false;
    }
    return true;
  }

  signUpProcess() async {
    print('Sign up process starts');
    Map<String, String> body = Map();
    var url = "$BASEURL/signup";
    body["email"] = _txtEmail.text;
    body["password"] = _txtPassword.text;
    body["name"] = _txtName.text;
    body["phone"] = _txtPhone.text;
    body["address"] = _txtAddress.text;
    try {
      FormData formData = new FormData.fromMap(body);
      var response = await Dio().post(url, data: formData);
      print(jsonDecode(response.data)['signup'] + "    :   SIGNUPPPPPPPP");
      if (jsonDecode(response.data)['signup'] == 'true') {
        setState(() {
          _isLoading = false;
        });
        showAlertDialog('Signed up successfully!', true);
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

        showAlertDialog(jsonDecode(response.data)['msg'], false);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
          msg: "SIGNUP ERROR",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
