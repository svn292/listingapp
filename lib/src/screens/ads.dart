import 'dart:convert';
import 'dart:io' show Platform;

import 'package:daangor/config/ui_icons.dart';
import 'package:daangor/src/models/FavsData.dart';
import 'package:daangor/src/models/category_model.dart';
import 'package:daangor/src/screens/WebViewScreen.dart';
import 'package:daangor/src/util/constants.dart';
import 'package:daangor/src/widgets/CategoryGridItemWidget.dart';
import 'package:daangor/src/widgets/CategoryListItemWidget.dart';
import 'package:daangor/src/widgets/EmptyFavoritesWidget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Ads extends StatefulWidget {
  @override
  _AdsState createState() => _AdsState();
}

class _AdsState extends State<Ads> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String layout = 'list';

  // UtilitiesList _utilitiesList = new UtilitiesList();
  List<CategoryModel> categoryItems = List();

  bool isLoading = false;

  @override
  void initState() {
    getAds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
//            Navigator.of(context).pushNamed(GetFormUser.id);
              TOKEN != "" ? isSubscriptionActive() : showAlertDialog('Please login first');
            }),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: TOKEN == ""
              ? Center(
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 70),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/SignIn');
                    },
                    child: Text(
                      'LOGIN',
                      style: Theme.of(context).textTheme.title.merge(
                            TextStyle(color: Theme.of(context).primaryColor),
                          ),
                    ),
                    color: Color.fromRGBO(55, 169, 157, 1),
                    shape: StadiumBorder(),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Offstage(
                      offstage: categoryItems.isEmpty,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 10),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          leading: Icon(
                            UiIcons.heart,
                            color: Theme.of(context).hintColor,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    this.layout = 'list';
                                  });
                                },
                                icon: Icon(
                                  Icons.format_list_bulleted,
                                  color: this.layout == 'list'
                                      ? Theme.of(context).focusColor
                                      : Theme.of(context).focusColor.withOpacity(0.4),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    this.layout = 'grid';
                                  });
                                },
                                icon: Icon(
                                  Icons.apps,
                                  color: this.layout == 'grid'
                                      ? Theme.of(context).focusColor
                                      : Theme.of(context).focusColor.withOpacity(0.4),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Offstage(
                      offstage: this.layout != 'list' || categoryItems.isEmpty,
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        primary: false,
                        itemCount: categoryItems.length,
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 10);
                        },
                        itemBuilder: (context, index) {
                          return CategoryListItemWidget(
                            heroTag: 'category_list',
                            categoryModel: categoryItems.elementAt(index),
                            onDismissed: () {
                              setState(() {
                                categoryItems.removeAt(index);
                              });
                            },
                          );
                        },
                      ),
                    ),
                    Offstage(
                      offstage: this.layout != 'grid' || categoryItems.isEmpty,
                      child: Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: new StaggeredGridView.countBuilder(
                          primary: false,
                          shrinkWrap: true,
                          crossAxisCount: 4,
                          itemCount: categoryItems.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CategoryGridItemWidget(
                              categoryModel: categoryItems.elementAt(index),
                              heroTag: 'category_grid',
                            );
                          },
//                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(index % 2 == 0 ? 1 : 2),
                          staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
                          mainAxisSpacing: 15.0,
                          crossAxisSpacing: 15.0,
                        ),
                      ),
                    ),
                    Offstage(
                      offstage: categoryItems.isNotEmpty,
                      child: EmptyFavoritesWidget(),
                    )
                  ],
                ),
        ),
      ),
    );
  }

  isSubscriptionActive() async {
    setState(() {
      isLoading = true;
    });
    Dio dio = Dio();
    dio.options.headers['authorization'] = TOKEN;
    var response = await dio.get('$BASEURL/currentpackage');
    setState(() {
      isLoading = false;
    });
    print('currentpackage - ${response.data}');
    if (response.data == '[]') {
//      showAlertDialog('Please subscribed first');
      Navigator.of(context).pushNamed(WebViewScreen.id, arguments: 2);
    } else if (response.data != '[]') {
      Navigator.of(context).pushNamed(WebViewScreen.id, arguments: 1);
    }
  }

  showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  getAds() async {
    categoryItems.clear();
    Dio dio = Dio();
    if (TOKEN != null && TOKEN != "") {
      dio.options.headers["authorization"] = TOKEN;

      var url = "$BASEURL/mylisting";
      var response = await dio.get(url);
      // List lst = jsonDecode(response.data);
      print(response.data);

      List<FavsData> favsData = (json.decode(response.data) as List).map((i) => FavsData.fromJson(i)).toList();
      print(favsData);

      if (this.mounted) {
        setState(() {
          for (FavsData dt in favsData) {
            categoryItems.add(CategoryModel(
                dt.id,
                dt.name,
                dt.listingCover == null
                    ? "https://daangor.com/uploads/listing_thumbnails/thumbnail.png"
                    : CAT_TUMB_BASE_URL + dt.listingCover));
          }
        });
      }
    }
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
}
