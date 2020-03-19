import 'package:daangor/config/ui_icons.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:daangor/src/models/userNW.dart';
import 'dart:convert';
import 'package:daangor/src/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class DrawerWidget extends StatefulWidget {
  // User _user = new User.init().getCurrentUser();
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  UserModel _user;

  getUserDetails() async {
    Dio dio = Dio();
    if (TOKEN != null && TOKEN != "") {
      dio.options.headers["authorization"] = TOKEN;
      var url = "$BASEURL/getuser";
      var userresponse = await dio.get(url);
      print(userresponse.data);
      setState(() {
        _user = UserModel(
            jsonDecode(userresponse.data)['name'],
            jsonDecode(userresponse.data)['email'],
            jsonDecode(userresponse.data)['address'],
            jsonDecode(userresponse.data)['phone']);
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
    return Drawer(
      child: ListView(
        children: <Widget>[
          (TOKEN == null || TOKEN == "")
              ? Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 50,),
                      Center(
                        child: FlatButton(
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 70),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/SignIn');
                          },
                          child: Text(
                            'Guest User',
                            style: Theme.of(context).textTheme.title.merge(
                                  TextStyle(color: Theme.of(context).primaryColor),
                                ),
                          ),
                          color: Theme.of(context).accentColor,
                          shape: StadiumBorder(),
                        ),
                      ),
                      SizedBox(height: 50,),
                    ],
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Tabs', arguments: 1);
                  },
                  child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Theme.of(context).hintColor.withOpacity(0.1),
                    ),
                    accountName: Text(
                      _user == null ? "" : _user.name,
                      style: Theme.of(context).textTheme.title,
                    ),
                    accountEmail: Text(
                      _user == null ? "" : _user.email,
                      style: Theme.of(context).textTheme.caption,
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Theme.of(context).accentColor,
                      backgroundImage: AssetImage("img/user0.jpg"),
                    ),
                  ),
                ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Tabs', arguments: 0);
            },
            leading: Icon(
              UiIcons.home,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Home",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          // ListTile(
          //   onTap: () {
          //     Navigator.of(context).pushNamed('/Tabs', arguments: 0);
          //   },
          //   leading: Icon(
          //     UiIcons.bell,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     "Notifications",
          //     style: Theme.of(context).textTheme.subhead,
          //   ),
          // ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Tabs', arguments: 2);
            },
            leading: Icon(
              UiIcons.heart,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Wish List",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Tabs', arguments: 1);
            },
            leading: Icon(
              UiIcons.folder_1,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Categories",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),

          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Tabs', arguments: 3);
            },
            leading: Icon(
              UiIcons.settings_1,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Settings",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          // ListTile(
          //   onTap: () {
          //     Navigator.of(context).pushNamed('/Languages');
          //   },
          //   leading: Icon(
          //     UiIcons.planet_earth,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     "Languages",
          //     style: Theme.of(context).textTheme.subhead,
          //   ),
          // ),
          (TOKEN == null || TOKEN == "")
              ? Container()
              : ListTile(
                  onTap: () async{
                     final prefs = await SharedPreferences.getInstance();
                            prefs.setString('token',
                                  "");
                    setState(() {
                      TOKEN="";
                    });
                    Navigator.of(context).pushReplacementNamed('/SignIn');
                  },
                  leading: Icon(
                    UiIcons.upload,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  title: Text(
                    "Log out",
                    style: Theme.of(context).textTheme.subhead,
                  ),
                ),
          /*ListTile(
            dense: true,
            title: Text(
              "Version 0.0.1",
              style: Theme.of(context).textTheme.body1,
            ),
            trailing: Icon(
              Icons.remove,
              color: Theme.of(context).focusColor.withOpacity(0.3),
            ),
          ),*/
        ],
      ),
    );
  }
}
