import 'dart:convert';

import 'package:daangor/config/ui_icons.dart';
import 'package:daangor/src/models/category.dart';
import 'package:daangor/src/models/listing.dart';
import 'package:daangor/src/models/utilities.dart';
import 'package:daangor/src/util/constants.dart';
import 'package:daangor/src/widgets/PopularLocationCarouselWidget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BrandHomeTabWidget extends StatefulWidget {
  Category category;
  UtilitiesList _utilitiesList = new UtilitiesList();

  BrandHomeTabWidget({this.category});

  @override
  _BrandHomeTabWidgetState createState() => _BrandHomeTabWidgetState();
}

class _BrandHomeTabWidgetState extends State<BrandHomeTabWidget> {
  List<ListingItem> listingItems = List();
  getPopularList() async {
    var response = await Dio().get("$BASEURL/popular_listing");
    print("MMMMMMMMM   ::   " + response.data);

    var data = jsonDecode(response.data);
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
                  dt['phone'],
                   dt['facility'],
                    dt['latitude'],
                     dt['longitude'],
                        dt['email'],
                        dt['time']));
      }
      
    });
  }

  @override
  void initState() {
    getPopularList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        /*Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),

          child: Center(
            child: Text(
              '${widget.category.name}',
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ),*/
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            leading: Icon(
              UiIcons.favorites,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              'Description',
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
              'We’re all going somewhere. And whether it’s the podcast blaring from your headphones as you walk down the street or the essay that encourages you to take on that big project, there’s a real joy in getting lost in the kind of story that feels like a destination unto itself.'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            leading: Icon(
              UiIcons.trophy,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              'Popular',
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ),
        PopularLocationCarouselWidget(
          heroTag: 'brand_featured_products',
          listingList: listingItems,
        ),
      ],
    );
  }
}
