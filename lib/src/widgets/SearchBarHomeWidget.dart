import 'dart:convert';

import 'package:daangor/config/ui_icons.dart';
import 'package:daangor/src/models/listing.dart';
import 'package:daangor/src/util/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchBarHomeWidget extends StatelessWidget {
  SearchBarHomeWidget({
    Key key,
  }) : super(key: key);
  final List<String> suggestions = [
    "Delux Room",
    "Tripple Room",
    "Single Room",
    "King Room"
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).hintColor.withOpacity(0.10),
              offset: Offset(0, 4),
              blurRadius: 10)
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).hintColor.withOpacity(0.4),
                    width: 1),
                borderRadius: BorderRadius.circular(10.0)),
            child: Stack(
              alignment: Alignment.centerRight,
              children: <Widget>[
                TextField(
                  onSubmitted: (value) async {

                    Navigator.of(context)
                        .pushNamed('/Search', arguments: value);


//                    int key=-1;
//                    CAT_LIST.forEach((k, v) {
//                      if(value.trim().toLowerCase()==v.toString().toLowerCase()){
//                        key=k;
//                      }
//                    });
// //  print("LLLLLLLLLL    :::    "+key.toString());
//                     if (key !=-1) {
//                       Navigator.of(context).pushNamed('/CategoriesItem',
//                           arguments: key);
//                     }else{
//                        Fluttertoast.showToast(
//                                 msg: "No Such Category",
//                                 toastLength: Toast.LENGTH_SHORT,
//                                 gravity: ToastGravity.BOTTOM,
//                                 timeInSecForIos: 1,
//                                 backgroundColor: Colors.red,
//                                 textColor: Colors.white,
//                                 fontSize: 16.0);
//                     }

                  //   var response =
                  //       await Dio().get("$BASEURL/search?search_string=$value");
                  //   print("MMMMMMMMM   ::   " + response.data);
                  //   var data = jsonDecode(response.data);
                  //   ListingItem listingItem = ListingItem(
                  //       data['code'],
                  //       data['name'],
                  //       data['listing_type'],
                  //       data['listing_cover'] == null
                  //           ? "https://daangor.com/uploads/listing_thumbnails/thumbnail.png"
                  //           : CAT_TUMB_BASE_URL + data['listing_cover'],
                  //       data['description'],
                  //       data['categories'][0],
                  //       data['address'],
                  //       data['phone'],
                  //       data['amenities'],
                  //       data['latitude'],
                  //       data['longitude'],
                  //       data['email'],
                  //       data['time']);
                  //   Navigator.of(context)
                  //       .pushNamed('/Utilities', arguments: listingItem);
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    hintText: 'Search',
                    hintStyle: TextStyle(
                        color: Theme.of(context).focusColor.withOpacity(0.8)),
                    prefixIcon: Icon(UiIcons.loupe,
                        size: 20, color: Theme.of(context).hintColor),
                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                    enabledBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
                // IconButton(
                //   onPressed: () {
                //     Scaffold.of(context).openEndDrawer();
                //   },
                //   icon: Icon(UiIcons.settings_2, size: 20, color: Theme.of(context).hintColor.withOpacity(0.5)),
                // ),
              ],
            ),
          ),
          // SizedBox(height: 6),
          // Wrap(
          //   alignment: WrapAlignment.spaceBetween,
          //   children: _buildSuggestions(suggestions,context),
          // )
        ],
      ),
    );
  }
}

_buildSuggestions(List<String> list, BuildContext context) {
  List<Widget> choices = List();
  list.forEach((item) {
    choices.add(
      Container(
        margin: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Theme.of(context).hintColor.withOpacity(0.2),
          ),
          padding:
              const EdgeInsets.only(left: 10.0, right: 10, top: 3, bottom: 3),
          child: Text(
            item,
            style: Theme.of(context).textTheme.body1.merge(
                  TextStyle(color: Theme.of(context).primaryColor),
                ),
          ),
        ),
      ),
    );
  });
  return choices;
}
