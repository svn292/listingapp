import 'package:daangor/src/models/listing.dart';
//import 'package:daangor/src/widgets/AvailableProgressBarWidget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PopularLocationCarouselItemWidget extends StatelessWidget {
  String heroTag;
  double marginLeft;
  ListingItem listingItem;

  PopularLocationCarouselItemWidget({
    Key key,
    this.heroTag,
    this.marginLeft,
    this.listingItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/Utilities', arguments: listingItem);
      },
      child: Container(
        margin: EdgeInsets.only(left: this.marginLeft, right: 20),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Hero(
              tag: heroTag + listingItem.hashCode.toString(),
              child: Container(
                width: 180,
                height: 185,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(listingItem.imgUrl),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 160),
              width: 140,
              height: 50,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(0.15),
                        offset: Offset(0, 3),
                        blurRadius: 10)
                  ]),
              child: Center(
                child: Text(
                  listingItem.name == null ? "" : listingItem.name,
                  style: Theme.of(context).textTheme.body2,
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                ),
                //SizedBox(height: 7),
                //Text(
                //'${utilitie.available} Available',
                //style: Theme.of(context).textTheme.body1,
                //overflow: TextOverflow.ellipsis,
                //),
              ),
            )
          ],
        ),
      ),
    );
  }
}
