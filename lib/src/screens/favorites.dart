import 'dart:convert';

import 'package:daangor/config/ui_icons.dart';
import 'package:daangor/src/util/constants.dart';
import 'package:daangor/src/widgets/EmptyFavoritesWidget.dart';
import 'package:daangor/src/widgets/FavoriteListItemWidget.dart';
import 'package:daangor/src/widgets/UtilitiesGridItemWidget.dart';
import 'package:daangor/src/widgets/SearchBarWidget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:daangor/src/models/listing.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FavoritesWidget extends StatefulWidget {
  @override
  _FavoritesWidgetState createState() => _FavoritesWidgetState();
}

class _FavoritesWidgetState extends State<FavoritesWidget> {
  String layout = 'list';
  List<ListingItem> listingItems = List();
    getWishList() async {
      Dio dio = Dio();
      if (TOKEN != null && TOKEN != "") {
        dio.options.headers["authorization"] = TOKEN;
        var url = "$BASEURL/wishlist";
        var response = await dio.get(url);
        print("MMMMMMMMM   ::   " + response.data);
   listingItems.clear();
        var data = jsonDecode(response.data);
        if (this.mounted) {
          setState(() {
         
            for (Map dt in data) {
              listingItems.add(ListingItem(
                  dt['code'],
                  dt['name'],
                  dt['listing_type'],
                  dt['listing_cover'] == null
                      ? "https://daangor.com/uploads/listing_thumbnails/thumbnail.png"
                      : CAT_TUMB_BASE_URL + dt['listing_cover'],
                  dt['description'],
                  dt['category'][0],
                  dt['address'],
                  dt['phone'],
                   dt['facility'],
                    dt['latitude'],
                     dt['longitude'],
                        dt['email'],
                        dt['time']
                  ));
            }
          });
        }
      }
    }

    @override
  void initState() {
    getWishList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 10),
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
                  offstage: listingItems.isEmpty,
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
                        'Wish List',
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
                  offstage: this.layout != 'list' ||
                     listingItems.isEmpty,
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    primary: false,
                    itemCount: listingItems.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 10);
                    },
                    itemBuilder: (context, index) {
                      return FavoriteListItemWidget(
                        heroTag: 'favorites_list',
                        listingItem:listingItems.elementAt(index),
                        onDismissed: () {
                          setState(() {
                            listingItems.removeAt(index);
                          });
                        },
                      );
                    },
                  ),
                ),
                Offstage(
                  offstage: this.layout != 'grid' ||
                     listingItems.isEmpty,
                  child: Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: new StaggeredGridView.countBuilder(
                      primary: false,
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      itemCount:listingItems.length,
                      itemBuilder: (BuildContext context, int index) {
                    
                        return UtilitietGridItemWidget(
                          listingItem: listingItems.elementAt(index),
                          heroTag: 'favorites_grid',
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
                  offstage:listingItems.isNotEmpty,
                  child: EmptyFavoritesWidget(),
                )
              ],
            ),
    );
  }
}
