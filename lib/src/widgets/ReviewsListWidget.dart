import 'package:daangor/src/models/listing.dart';
import 'package:daangor/src/models/review.dart';
import 'package:daangor/src/widgets/ReviewItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class ReviewsListWidget extends StatefulWidget {
  ListingItem listingItem;

  ReviewsListWidget(this.listingItem);

  @override
  _ReviewsListWidgetState createState() => _ReviewsListWidgetState();
}

class _ReviewsListWidgetState extends State<ReviewsListWidget> {
  GoogleMapController _googleMapController;

  Set<Marker> markers = Set();
  void _onMapCreated(GoogleMapController mapController) async {
    setState(() {});
    print("onMapCreated");
    _googleMapController = mapController;
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: mrkr,
      zoom: 5,
    )));
  }

  //  Completer<GoogleMapController> _controller = Completer();

  CameraPosition initPosition;
  LatLng mrkr = LatLng(0, 0);

  @override
  void initState() {
    print("PPPPPPPPPPPPPPPPPPPP  ::  " +
        widget.listingItem.lat +
        "LLLLLLL" +
        widget.listingItem.long);
    mrkr = LatLng(
        (widget.listingItem.lat == null || widget.listingItem.lat == "")
            ? 0
            : double.parse(widget.listingItem.lat),
        (widget.listingItem.long == null || widget.listingItem.long == "")
            ? 0
            : double.parse(widget.listingItem.long));

    initPosition = CameraPosition(
      target: mrkr,
      zoom: 5,
    );

    print("PPPPPPPPPPPPPPPPPPPP  ::  " + mrkr.toString());
    markers.add(Marker(
      markerId: MarkerId("1"),
      position: mrkr,
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Text(
              "ADDRESS :  ${widget.listingItem.address == null ? '' : widget.listingItem.address}",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
         
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Text(
              "PHONE NO :  ${widget.listingItem.phone == null ? '' : widget.listingItem.phone}",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Container(
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: initPosition,
                  onMapCreated: _onMapCreated,
                  markers: markers,
                ),
                height: 300),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        onPressed: () async {
                          // UrlLauncher.launch('tel :+${widget.listingItem.phone}')
                          if (await canLaunch(
                              "tel:${widget.listingItem.phone}")) {
                            await launch("tel:${widget.listingItem.phone}");
                          } else {
                            throw 'Could not launch';
                          }
                        },
                        child: Text(
                          'CALL',
                          style: Theme.of(context).textTheme.title.merge(
                                TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                        ))),
                Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      onPressed: () async {
                        if (await canLaunch(
                            "mailto:${widget.listingItem.email}")) {
                          await launch("mailto:${widget.listingItem.email}");
                        } else {
                          throw 'Could not launch';
                        }
                      },
                      child: Text(
                        'EMAIL',
                        style: Theme.of(context).textTheme.title.merge(
                              TextStyle(color: Theme.of(context).primaryColor),
                            ),
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
    // return ListView.separated(
    //   padding: EdgeInsets.symmetric(horizontal: 20),
    //   itemBuilder: (context, index) {
    //     return ReviewItemWidget(review: _reviewsList.reviewsList.elementAt(index));
    //   },
    //   separatorBuilder: (context, index) {
    //     return Divider(
    //       height: 30,
    //     );
    //   },
    //   itemCount: _reviewsList.reviewsList.length,
    //   primary: false,
    //   shrinkWrap: true,
    // );
  }
}
