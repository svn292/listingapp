import 'package:daangor/config/ui_icons.dart';
import 'package:flutter/material.dart';
import 'package:daangor/src/util/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:daangor/src/models/listing.dart';

class SearchBarWidget extends StatelessWidget {
  SearchBarWidget({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
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
          Stack(
            alignment: Alignment.centerRight,
            children: <Widget>[
              TextField(
                onSubmitted: (value) async {
                  //             var response = await Dio()
                  //     .get("$BASEURL/search?search_string=$value");
                  // print("MMMMMMMMM   ::   " + response.data);
                  // var data = jsonDecode(response.data);
                  // ListingItem listingItem = ListingItem(
                  //     data['code'],
                  //     data['name'],
                  //     data['listing_type'],
                  //     data['listing_cover'] == null
                  //         ? "https://daangor.com/uploads/listing_thumbnails/thumbnail.png"
                  //         : CAT_TUMB_BASE_URL + data['listing_cover'],
                  //     data['description'],
                  //           data['category'][0],
                  //         data['address'],
                  //         data['phone'],
                  //          data['facility'],
                  //           data['latitude'],
                  //            data['longitude'],
                  //               data['email'],
                  //               data['time']);
                  // Navigator.of(context).pushNamed('/Utilities', arguments: listingItem);

                  Navigator.of(context).pushNamed('/Search', arguments: value);

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
        ],
      ),
    );
  }
}
