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
import 'package:daangor/src/widgets/SearchBarWidget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CategoriesNew extends StatefulWidget {
  CategoriesNew(this.id);
  int id;
  @override
  _CategoriesNewState createState() => _CategoriesNewState();
}

class _CategoriesNewState extends State<CategoriesNew> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String layout = 'list';
  // UtilitiesList _utilitiesList = new UtilitiesList();
  List<CategoryModel> categoryItems = List();
  getCategoryItemList(int id) async {
    categoryItems.clear();
    var response = await Dio().get("$BASEURL/listingbycategory/$id");
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

  @override
  void initState() {
    getCategoryItemList(widget.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("PPPPPPPPPPPP  : " + widget.id.toString());
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: DrawerWidget(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: new IconButton(
            icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            children: <Widget>[
              Text(
                "Category List",
                style: Theme.of(context).textTheme.display1,
              ), SizedBox(width: 20,),
            Image.asset("img/dark_logo.png", width: 100,)
            ],
          ),
          
          actions: <Widget>[
            //new ShoppingCartButtonWidget(
            // iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
            //   Container(
            //       width: 30,
            //       height: 30,
            //       margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
            //       child: InkWell(
            //         borderRadius: BorderRadius.circular(300),
            //         onTap: () {
            //           Navigator.of(context).pushNamed('/Tabs', arguments: 1);
            //         },
            //         child: CircleAvatar(
            //           backgroundImage: AssetImage('img/user2.jpg'),
            //         ),
            //       )),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SearchBarWidget(),
              ),
              SizedBox(height: 10),
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
                    title: Text(
                      CAT_LIST[widget.id],
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: Theme.of(context).textTheme.display1,
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
        ),
      ),
    );
  }
}
