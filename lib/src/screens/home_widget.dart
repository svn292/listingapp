import 'dart:convert';

import 'package:daangor/config/ui_icons.dart';
import 'package:daangor/src/models/category.dart';
import 'package:daangor/src/models/city_model.dart';
import 'package:daangor/src/models/listing.dart';
import 'package:daangor/src/models/utilities.dart';
import 'package:daangor/src/providers/data_provider.dart';
import 'package:daangor/src/util/CustomInterceptors.dart';
import 'package:daangor/src/util/constants.dart';
import 'package:daangor/src/widgets/CategoriesIconsContainerWidget.dart';
import 'package:daangor/src/widgets/HomeSliderWidget.dart';
import 'package:daangor/src/widgets/PopularLocationCarouselWidget.dart';
import 'package:daangor/src/widgets/SearchBarHomeWidget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with SingleTickerProviderStateMixin {
  Future<List<ListingItem>> listingItems;

  getCategoryList() async {
    List categories = List();
    try {
      var response = await Dio().get("$BASEURL/getallcategory");
      categories = jsonDecode(response.data);
    } catch (e) {
      print(e);
    }
  }

  List<Utilitie> _utilitiesOfCategoryList;
  List<Utilitie> _utilitiesfBrandList;
  CategoriesList _categoriesList = new CategoriesList();
  UtilitiesList _utilitiesList = new UtilitiesList();

  Animation animationOpacity;
  AnimationController animationController;

  @override
  void initState() {
    // print("LLLLLLLLLLLLLLLLLLLLL   :   " + TOKEN);
//    getCategoryList();

    animationController = AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    CurvedAnimation curve = CurvedAnimation(parent: animationController, curve: Curves.easeIn);
    animationOpacity = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        // setState(() {});
      });

    animationController.forward();

    _utilitiesOfCategoryList = _categoriesList.list.firstWhere((category) {
      return category.selected;
    }).utilities;

    //_utilitiesfBrandList = _brandsList.list.firstWhere((brand) {
    //return brand.selected;
    //}).utilities;
    listingItems = getPopularList(null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (BuildContext context, value, Widget child) {
        if (value.getCityModel() != null) {
          print('--------------Consumer- ${value.getCityModel().name}');
          listingItems = getPopularList(value.getCityModel());
        }
        return FutureBuilder(
          future: listingItems,
          builder: (BuildContext context, AsyncSnapshot<List<ListingItem>> snapshot) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      HomeSliderWidget(),
                      Container(
                        margin: const EdgeInsets.only(top: 150, bottom: 20),
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: SearchBarHomeWidget(),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 2, left: 2),
                    child: CategoriesIconsContainerWidget(
                      categoriesList: _categoriesList,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                            leading: Icon(
                              UiIcons.favorites,
                              color: Theme.of(context).hintColor,
                            ),
                            title: Text(
                              'Popular',
                              style: Theme.of(context).textTheme.display1,
                            ),
                          ),
                        ],
                      )),
                  snapshot.hasData
                      ? PopularLocationCarouselWidget(heroTag: 'home_flash_sales', listingList: snapshot.data)
                      : Container(),

                  //   Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  //     child:Column(
                  //       children: <Widget>[
                  //         ListTile(
                  //           dense: true,
                  //           contentPadding: EdgeInsets.symmetric(vertical: 0),
                  //           leading: Icon(
                  //             UiIcons.box,
                  //             color: Theme.of(context).hintColor,
                  //           ),
                  //           title: Text(
                  //             'Recent',
                  //             style: Theme.of(context).textTheme.display1,
                  //           ),
                  //         ),
                  //       ],
                  //     )

                  // ),
                  //   CategorizedUtilitiesWidget(animationOpacity : animationOpacity ,utilitiesList: _utilitiesList.recentList,)
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<List<ListingItem>> getPopularList(CityModel cityModel) async {
//    var prefs = await SharedPreferences.getInstance();

    var _cityModel = cityModel;

    var dio = Dio();
    dio.interceptors.add(CustomInterceptors());
    String url = '$BASEURL/popular_listing';

    if (_cityModel != null) {
      url = url + '?city=${_cityModel.id}';
    }
    var response = await dio.get(url);
    var data = jsonDecode(response.data);

    List<ListingItem> listingItemsData = [];
    listingItemsData.clear();
    for (Map dt in data) {
      listingItemsData.add(ListingItem(
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

    return listingItemsData;

    /*if (this.mounted) {
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
    }*/
  }
}
