import 'dart:convert';
import 'dart:io';

import 'package:daangor/config/ui_icons.dart';
import 'package:daangor/src/models/userNW.dart';
import 'package:daangor/src/util/constants.dart';
import 'package:daangor/src/widgets/SearchBarWidget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AccountWidget extends StatefulWidget {
  @override
  _AccountWidgetState createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  PickedFile _imageFile;
  dynamic _pickImageError;
  double textFieldWidth = 200;
  final ImagePicker _picker = ImagePicker();
  UserModel _user;

  TextEditingController _txtName = TextEditingController();
  TextEditingController _txtEmail = TextEditingController();
  TextEditingController _txtAddress = TextEditingController();
  TextEditingController _txtPhone = TextEditingController();
  bool _isLoading = false;

  getUserDetails() async {
    Dio dio = Dio();
    if (TOKEN != null && TOKEN != "") {
      dio.options.headers['authorization'] = TOKEN;
      var url = '$BASEURL/getuser';
      var userresponse = await dio.get(url);

      print('account page');
      print(userresponse.data);
      setState(() {
        /*_user = UserModel(
             jsonDecode(userresponse.data)['name'],
            jsonDecode(userresponse.data)['email'],
            jsonDecode(userresponse.data)['address'],
            jsonDecode(userresponse.data)['phone'],
            jsonDecode(userresponse.data)['phone']);*/

        _user = UserModel.fromJson(jsonDecode(userresponse.data));

        _txtName.text = _user.name;
        _txtEmail.text = _user.email;
        _txtAddress.text = _user.address;
        _txtPhone.text = _user.phone;
      });
    }
  }

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 7),
        child: (TOKEN == null || TOKEN == "")
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 70),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/SignIn');
                    },
                    child: Text(
                      'SIGN IN',
                      style: Theme.of(context).textTheme.title.merge(
                            TextStyle(color: Theme.of(context).primaryColor),
                          ),
                    ),
                    color: Theme.of(context).accentColor,
                    shape: StadiumBorder(),
                  ),
                ),
              )
            : Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SearchBarWidget(),
                  ),
                  /*Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text(_user == null ? "" : _user.name,
                                  textAlign: TextAlign.left, style: Theme.of(context).textTheme.display2),
                              Text(_user == null ? "" : _user.email, style: Theme.of(context).textTheme.caption)
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                        // SizedBox(
                        //     width: 55,
                        //     height: 55,
                        //     child: InkWell(
                        //       borderRadius: BorderRadius.circular(300),
                        //       onTap: () {
                        //         Navigator.of(context).pushNamed('/Tabs', arguments: 1);
                        //       },
                        //       child: CircleAvatar(
                        //         backgroundImage: AssetImage(_user.avatar),
                        //       ),
                        //     )),
                      ],
                    ),
                  ),*/
                  // Container(
                  //   margin: EdgeInsets.symmetric(horizontal: 20),
                  //   decoration: BoxDecoration(
                  //     color: Theme.of(context).primaryColor,
                  //     borderRadius: BorderRadius.circular(6),
                  //     boxShadow: [
                  //       BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.15), offset: Offset(0, 3), blurRadius: 10)
                  //     ],
                  //   ),
                  //   child: Row(
                  //     children: <Widget>[
                  //       Expanded(
                  //         child: FlatButton(
                  //           padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  //           onPressed: () {
                  //             Navigator.of(context).pushNamed('/Tabs', arguments: 4);
                  //           },
                  //           child: Column(
                  //             children: <Widget>[
                  //               Icon(UiIcons.heart),
                  //               Text(
                  //                 'Wish List',
                  //                 style: Theme.of(context).textTheme.body1,
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: FlatButton(
                  //           padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  //           onPressed: () {
                  //             Navigator.of(context).pushNamed('/Tabs', arguments: 0);
                  //           },
                  //           child: Column(
                  //             children: <Widget>[
                  //               Icon(UiIcons.favorites),
                  //               Text(
                  //                 'Following',
                  //                 style: Theme.of(context).textTheme.body1,
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: FlatButton(
                  //           padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  //           onPressed: () {
                  //             Navigator.of(context).pushNamed('/Tabs', arguments: 3);
                  //           },
                  //           child: Column(
                  //             children: <Widget>[
                  //               Icon(UiIcons.chat_1),
                  //               Text(
                  //                 'Messages',
                  //                 style: Theme.of(context).textTheme.body1,
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      showCameraGalleryDialog();
                    },
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Theme.of(context).accentColor,
                      backgroundImage: _imageFile == null
                          ? NetworkImage(_user == null ? kThumbnailsPic : '$kImageBaseUrl' + _user.profileImage)
                          : FileImage(File(_imageFile.path)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.15), offset: Offset(0, 3), blurRadius: 10)
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(UiIcons.user_1),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Profile Settings',
                              style: Theme.of(context).textTheme.body2,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Name',
                              style: TextStyle(color: Theme.of(context).focusColor),
                            ),
                            Flexible(
                              child: Container(
                                width: textFieldWidth,
                                child: TextField(
                                  controller: _txtName,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(color: Color(0xffC2C2C2)),
                                    contentPadding: EdgeInsets.all(8),
                                    border: InputBorder.none,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                        borderSide: BorderSide(color: Color(0xffC2C2C2))),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                      borderSide: BorderSide(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(color: Theme.of(context).focusColor),
                            ),
                            Flexible(
                              child: Container(
                                width: textFieldWidth,
                                child: TextField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: _txtEmail,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(color: Color(0xffC2C2C2)),
                                    contentPadding: EdgeInsets.all(8),
                                    isDense: true,
                                    border: InputBorder.none,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                        borderSide: BorderSide(color: Color(0xffC2C2C2))),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                      borderSide: BorderSide(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Address',
                              style: TextStyle(color: Theme.of(context).focusColor),
                            ),
                            Flexible(
                              child: Container(
                                width: textFieldWidth,
                                child: TextField(
                                  controller: _txtAddress,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(color: Color(0xffC2C2C2)),
                                    contentPadding: EdgeInsets.all(8),
                                    isDense: true,
                                    border: InputBorder.none,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                        borderSide: BorderSide(color: Color(0xffC2C2C2))),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                      borderSide: BorderSide(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Phone',
                              style: TextStyle(color: Theme.of(context).focusColor),
                            ),
                            Flexible(
                              child: Container(
                                width: textFieldWidth,
                                child: TextField(
                                  controller: _txtPhone,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(color: Color(0xffC2C2C2)),
                                    contentPadding: EdgeInsets.all(8),
                                    isDense: true,
                                    border: InputBorder.none,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                        borderSide: BorderSide(color: Color(0xffC2C2C2))),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                      borderSide: BorderSide(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        FlatButton(
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 70),
                          onPressed: () {
                            if (validation()) {
                              setState(() {
                                _isLoading = true;
                              });
                              editProfile();
                            }
                          },
                          child: Text(
                            'Update Profile',
                            style: Theme.of(context).textTheme.title.merge(
                                  TextStyle(color: Theme.of(context).primaryColor),
                                ),
                          ),
                          color: Theme.of(context).accentColor,
                          shape: StadiumBorder(),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: false,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.15), offset: Offset(0, 3), blurRadius: 10)
                        ],
                      ),
                      child: Column(
                        children: [
                          ListView(
                            shrinkWrap: true,
                            primary: false,
                            children: <Widget>[
                              ListTile(
                                leading: Icon(UiIcons.user_1),
                                title: Text(
                                  'Profile Settings',
                                  style: Theme.of(context).textTheme.body2,
                                ),
                                // trailing: ButtonTheme(
                                //   padding: EdgeInsets.all(0),
                                //   minWidth: 50.0,
                                //   height: 25.0,
                                //   child: ProfileSettingsDialog(
                                //     user: this._user,
                                //     onChanged: () {
                                //       setState(() {});
                                //     },
                                //   ),
                                // ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Name',
                                    style: TextStyle(color: Theme.of(context).focusColor),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Flexible(
                                    child: TextField(
                                      controller: _txtName,
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(color: Color(0xffC2C2C2)),
                                        contentPadding: EdgeInsets.all(8),
                                        isDense: true,
                                        border: InputBorder.none,
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                            borderSide: BorderSide(color: Color(0xffC2C2C2))),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                          borderSide: BorderSide(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Email',
                                    style: TextStyle(color: Theme.of(context).focusColor),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Flexible(
                                      child: TextField(
                                    controller: _txtEmail,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(color: Color(0xffC2C2C2)),
                                      contentPadding: EdgeInsets.all(8),
                                      isDense: true,
                                      border: InputBorder.none,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                          borderSide: BorderSide(color: Color(0xffC2C2C2))),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                        borderSide: BorderSide(color: Colors.black),
                                      ),
                                    ),
                                  ))
                                ],
                              ),
                              ListTile(
                                onTap: () {},
                                dense: true,
                                title: Text(
                                  'Full name',
                                  style: Theme.of(context).textTheme.body1,
                                ),
                                trailing: Text(
                                  _user == null ? "" : _user.name,
                                  style: TextStyle(color: Theme.of(context).focusColor),
                                ),
                              ),
                              ListTile(
                                onTap: () {},
                                dense: true,
                                title: Text(
                                  'Email',
                                  style: Theme.of(context).textTheme.body1,
                                ),
                                trailing: Text(
                                  _user == null ? "" : _user.email,
                                  style: TextStyle(color: Theme.of(context).focusColor),
                                ),
                              ),
                              ListTile(
                                onTap: () {},
                                dense: true,
                                title: Text(
                                  'Address',
                                  style: Theme.of(context).textTheme.body1,
                                ),
                                trailing: Text(
                                  _user == null ? "" : _user.address,
                                  style: TextStyle(color: Theme.of(context).focusColor),
                                ),
                              ),
                              ListTile(
                                onTap: () {},
                                dense: true,
                                title: Text(
                                  'phone',
                                  style: Theme.of(context).textTheme.body1,
                                ),
                                trailing: Text(
                                  _user == null ? "" : _user.phone,
                                  style: TextStyle(color: Theme.of(context).focusColor),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  //   decoration: BoxDecoration(
                  //     color: Theme.of(context).primaryColor,
                  //     borderRadius: BorderRadius.circular(6),
                  //     boxShadow: [
                  //       BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.15), offset: Offset(0, 3), blurRadius: 10)
                  //     ],
                  //   ),
                  //   child: ListView(
                  //     shrinkWrap: true,
                  //     primary: false,
                  //     children: <Widget>[
                  //       ListTile(
                  //         leading: Icon(UiIcons.settings_1),
                  //         title: Text(
                  //           'Account Settings',
                  //           style: Theme.of(context).textTheme.body2,
                  //         ),
                  //       ),
                  //       ListTile(
                  //         onTap: () {},
                  //         dense: true,
                  //         title: Row(
                  //           children: <Widget>[
                  //             Icon(
                  //               UiIcons.placeholder,
                  //               size: 22,
                  //               color: Theme.of(context).focusColor,
                  //             ),
                  //             SizedBox(width: 10),
                  //             Text(
                  //               'Shipping Adresses',
                  //               style: Theme.of(context).textTheme.body1,
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       ListTile(
                  //         onTap: () {
                  //           Navigator.of(context).pushNamed('/Languages');
                  //         },
                  //         dense: true,
                  //         title: Row(
                  //           children: <Widget>[
                  //             Icon(
                  //               UiIcons.planet_earth,
                  //               size: 22,
                  //               color: Theme.of(context).focusColor,
                  //             ),
                  //             SizedBox(width: 10),
                  //             Text(
                  //               'Languages',
                  //               style: Theme.of(context).textTheme.body1,
                  //             ),
                  //           ],
                  //         ),
                  //         trailing: Text(
                  //           'English',
                  //           style: TextStyle(color: Theme.of(context).focusColor),
                  //         ),
                  //       ),
                  //       ListTile(
                  //         onTap: () {
                  //           Navigator.of(context).pushNamed('/Help');
                  //         },
                  //         dense: true,
                  //         title: Row(
                  //           children: <Widget>[
                  //             Icon(
                  //               UiIcons.information,
                  //               size: 22,
                  //               color: Theme.of(context).focusColor,
                  //             ),
                  //             SizedBox(width: 10),
                  //             Text(
                  //               'Help & Support',
                  //               style: Theme.of(context).textTheme.body1,
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
      ),
    );
  }

  editProfile() async {
    Dio dio = Dio();
    dio.options.headers["authorization"] = TOKEN;

    print('Sign up process starts');
    Map<String, String> body = Map();
    var url = "$BASEURL/editprofile";

    Map<String, dynamic> formData = Map();
    formData['email'] = _txtEmail.text;
    formData['name'] = _txtName.text;
    formData['phone'] = _txtPhone.text;
    formData['address'] = _txtAddress.text;
    if (_imageFile != null) {
      formData['profile_image'] = await MultipartFile.fromFile(_imageFile.path, filename: _imageFile.path.split('/').last);
    }

//    FormData form = FormData.fromMap({
//      'email': _txtEmail.text,
//      'name': _txtName.text,
//      'phone': _txtPhone.text,
//      'address': _txtAddress.text,
//      'profile_image': await MultipartFile.fromFile(_imageFile.path, filename: _imageFile.path.split('/').last),
//    });
    FormData form = FormData.fromMap(formData);

    var response = await dio.post(url, data: form);
    print(response.data);
    try {
      showAlertDialog(jsonDecode(response.data)['msg']);
    } on Exception catch (e) {
      print(e.toString());
    }
    setState(() {
      _isLoading = false;
    });
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

  showCameraGalleryDialog() {
    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Select Image from'),
            actions: [
              FlatButton(
                child: Text('Camera'),
                onPressed: () {
                  Navigator.pop(context);
                  pickUserImage(ImageSource.camera);
                },
              ),
              FlatButton(
                child: Text('Gallery'),
                onPressed: () {
                  Navigator.pop(context);
                  pickUserImage(ImageSource.gallery);
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
            content: Text('Select Image from'),
            actions: [
              CupertinoButton(
                child: Text('Camera'),
                onPressed: () {
                  Navigator.pop(context);
                  pickUserImage(ImageSource.camera);
                },
              ),
              CupertinoButton(
                child: Text('Gallery'),
                onPressed: () {
                  Navigator.pop(context);
                  pickUserImage(ImageSource.gallery);
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> pickUserImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.getImage(source: source);
      setState(() {
        if (pickedFile == null) {
          showAlertDialog('Image not selected');
        }
        _imageFile = pickedFile;
      });
    } on Exception catch (e) {
      print(e.toString());
      setState(() {
        _pickImageError = e;
      });
    }
  }
}
