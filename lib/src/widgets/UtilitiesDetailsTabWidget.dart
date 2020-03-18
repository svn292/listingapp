import 'dart:convert';

import 'package:daangor/config/ui_icons.dart';
import 'package:daangor/src/models/listing.dart';
import 'package:daangor/src/models/utilities.dart';
import 'package:daangor/src/util/constants.dart';
import 'package:daangor/src/widgets/PopularLocationCarouselWidget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UtilitiesDetailsTabWidget extends StatefulWidget {
  Utilitie utilitie;
  UtilitiesList _utilitiesList = new UtilitiesList();

  UtilitiesDetailsTabWidget({this.utilitie});

  @override
  UtilitiesDetailsTabWidgetState createState() =>
      UtilitiesDetailsTabWidgetState();
}

class UtilitiesDetailsTabWidgetState extends State<UtilitiesDetailsTabWidget> {
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
            dt['phone']));
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            leading: Icon(
              UiIcons.file_2,
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
              UiIcons.box,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              'Related Poducts',
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ),
        PopularLocationCarouselWidget(
          heroTag: 'product_details_related_products',
          listingList: listingItems,
        ),
      ],
    );
  }
}

class SelectColorWidget extends StatefulWidget {
  SelectColorWidget({
    Key key,
  }) : super(key: key);

  @override
  _SelectColorWidgetState createState() => _SelectColorWidgetState();
}

class _SelectColorWidgetState extends State<SelectColorWidget> {
  List<Color> _colors = [
    Colors.green,
    Colors.blue,
    Colors.red,
    Colors.black45,
    Colors.orange,
  ];

  Color _selectedColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _colors.map((color) {
        return buildColor(color, _selectedColor);
      }).toList(),
    );
  }

  SizedBox buildColor(color, selectedColor) {
    return SizedBox(
      width: 38,
      height: 38,
      child: FilterChip(
        label: Text(''),
        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
        backgroundColor: color,
        selectedColor: color,
        selected: selectedColor == color,
        shape: StadiumBorder(),
        avatar: Text(''),
        onSelected: (bool value) {
          setState(() {
            this._selectedColor = color;
          });
        },
      ),
    );
  }
}
