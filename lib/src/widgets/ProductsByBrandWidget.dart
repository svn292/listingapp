import 'package:daangor/config/ui_icons.dart';
import 'package:daangor/src/models/category.dart';
import 'package:daangor/src/models/utilities.dart';
import 'package:daangor/src/widgets/FavoriteListItemWidget.dart';
import 'package:daangor/src/widgets/UtilitiesGridItemWidget.dart';
import 'package:daangor/src/widgets/SearchBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:daangor/src/util/constants.dart';
import 'dart:convert';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:daangor/src/models/listing.dart';

// ignore: must_be_immutable
class UtilitiesByBrandWidget extends StatefulWidget {
  Category category;

  UtilitiesByBrandWidget({Key key, this.category}) : super(key: key);

  @override
  _UtilitiesByBrandWidgetState createState() => _UtilitiesByBrandWidgetState();
}

class _UtilitiesByBrandWidgetState extends State<UtilitiesByBrandWidget> {
  String layout = 'grid';
  List<ListingItem> listingItems = List();
  getWishList() async {
    Dio dio = Dio();
    if (TOKEN != null && TOKEN != "") {
      dio.options.headers["authorization"] = TOKEN;
      var url = "$BASEURL/getuser";
      var response = await dio.get(url);
      print("MMMMMMMMM   ::   " + response.data);

      var data = jsonDecode(response.data);
      if (this.mounted) {
        setState(() {
          listingItems.clear();
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
                  dt['phone']));
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
    return Wrap(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: SearchBarWidget(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 10),
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            leading: Icon(
              UiIcons.box,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              '${widget.category.name} Items',
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
        Offstage(
          offstage: this.layout != 'list',
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            itemCount: widget.category.utilities.length,
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
            itemBuilder: (context, index) {
              return FavoriteListItemWidget(
                heroTag: 'Utilities_by_category_list',
                listingItem: listingItems.elementAt(index),
                onDismissed: () {
                  setState(() {
                    widget.category.utilities.removeAt(index);
                  });
                },
              );
            },
          ),
        ),
        Offstage(
          offstage: this.layout != 'grid',
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: new StaggeredGridView.countBuilder(
              primary: false,
              shrinkWrap: true,
              crossAxisCount: 4,
              itemCount: widget.category.utilities.length,
              itemBuilder: (BuildContext context, int index) {
                Utilitie utilitie = widget.category.utilities.elementAt(index);
                return UtilitietGridItemWidget(
                  listingItem: listingItems.elementAt(index),
                  heroTag: 'Utilities_by_category_grid',
                );
              },
//                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(index % 2 == 0 ? 1 : 2),
              staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
              mainAxisSpacing: 15.0,
              crossAxisSpacing: 15.0,
            ),
          ),
        ),
      ],
    );
  }
}
