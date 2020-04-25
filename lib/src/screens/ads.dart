import 'dart:convert';

import 'package:daangor/config/ui_icons.dart';
import 'package:daangor/src/models/category_model.dart';
import 'package:daangor/src/models/utilities.dart';
import 'package:daangor/src/util/constants.dart';
import 'package:daangor/src/widgets/CategoryGridItemWidget.dart';
import 'package:daangor/src/widgets/CategoryListItemWidget.dart';
import 'package:daangor/src/widgets/DrawerWidget.dart';
import 'package:daangor/src/widgets/EmptyFavoritesWidget.dart';
import 'package:daangor/src/widgets/FavoriteListItemWidget.dart';
import 'package:daangor/src/widgets/UtilitiesGridItemWidget.dart';
// import 'package:daangor/src/widgets/SearchBarWidget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Ads extends StatefulWidget {
  @override
  _AdsState createState() => _AdsState();
}

class _AdsState extends State<Ads> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String layout = 'list';
  // UtilitiesList _utilitiesList = new UtilitiesList();
  List<CategoryModel> categoryItems = List();
  getAds() async {
    categoryItems.clear();
    Dio dio = Dio();
    if (TOKEN != null && TOKEN != "") {
      dio.options.headers["authorization"] = TOKEN;

      var url = "$BASEURL/mylisting";
      var response = await dio.get(url);
      List lst = jsonDecode(response.data);
      print(lst);
      if (this.mounted) {
        setState(() {
          for (Map dt in lst) {
            // categoryItems.add(CategoryModel((dt)['id'], (dt)['name'],
            //     CAT_TUMB_BASE_URL + (dt)['listing_thumbnail']));
            categoryItems.add(CategoryModel(
                (dt)['id'],
                (dt)['name'],
                (dt)['listing_cover'] == null
                    ? "https://daangor.com/uploads/listing_thumbnails/thumbnail.png"
                    : CAT_TUMB_BASE_URL + (dt)['listing_cover']));
          }
        });
      }
    }
  }

  @override
  void initState() {
    getAds();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                                  : Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.4),
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
                                  : Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.4),
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
                      staggeredTileBuilder: (int index) =>
                          new StaggeredTile.fit(2),
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
    );
  }
}
