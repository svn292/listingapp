import 'package:daangor/src/models/listing.dart';
import 'package:daangor/src/widgets/PopularLocationCarouselItemWidget.dart';
import 'package:flutter/material.dart';

class PopularLocationCarouselWidget extends StatelessWidget {
  final List<ListingItem> listingList;
  final String heroTag;

  PopularLocationCarouselWidget({
    Key key,
    this.listingList,
    this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 230,
        margin: EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: listingList.length,
          itemBuilder: (context, index) {
            double _marginLeft = 0;
            (index == 0) ? _marginLeft = 20 : _marginLeft = 0;
            return PopularLocationCarouselItemWidget(
              heroTag: this.heroTag,
              marginLeft: _marginLeft,
              listingItem: listingList.elementAt(index),
            );
          },
          scrollDirection: Axis.horizontal,
        ));
  }
}
