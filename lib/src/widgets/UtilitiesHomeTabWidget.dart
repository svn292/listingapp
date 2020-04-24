import 'package:daangor/config/ui_icons.dart';
import 'package:daangor/src/models/listing.dart';
import 'package:daangor/src/models/product_color.dart';
import 'package:daangor/src/util/constants.dart';
import 'package:daangor/src/widgets/PopularLocationCarouselWidget.dart';
import 'package:flutter/material.dart';
import 'package:daangor/src/models/utilities.dart';
import 'package:share/share.dart';

// ignore: must_be_immutable
class UtilitieHomeTabWidget extends StatefulWidget {
  ListingItem listingItem;
  // UtilitiesList _productsList = new UtilitiesList();

  UtilitieHomeTabWidget(this.listingItem);

  @override
  UtilitieHomeTabWidgetState createState() => UtilitieHomeTabWidgetState();
}

class UtilitieHomeTabWidgetState extends State<UtilitieHomeTabWidget> {
  List<TableRow> _tblData = List();
  List<Text> _facility = List();
  setTableData() {
    try {
      setState(() {
        _tblData.clear();
        _facility.clear();
        if (widget.listingItem.time != null && widget.listingItem.time != "") {
          widget.listingItem.time.forEach((key, value) {
            if (key != "id" && key != "listing_id") {
              _tblData.add(TableRow(children: [
                Center(child: Text(key)),
                Center(child: Text(value))
              ]));
            }
          });
        }
        if (widget.listingItem.facility != null &&
            widget.listingItem.facility != "") {
          for (var ts in widget.listingItem.facility) {
            _facility.add(Text(ts));
          }
        }
      });
    } catch (e) {
      dispose();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    setTableData();
    print("AAAAAAAAAAAA   " + widget.listingItem.code);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.listingItem.facility);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 22, left: 20, right: 20),
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(
                  widget.listingItem.name == null
                      ? ""
                      : widget.listingItem.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.display2,
                ),
              ),
              // Chip(
              //   padding: EdgeInsets.all(0),
              //   label: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: <Widget>[
              //       Text(widget.utilitie.rate.toString(),
              //           style: Theme.of(context).textTheme.body2.merge(
              //               TextStyle(color: Theme.of(context).primaryColor))),
              //       SizedBox(width: 4),
              //       Icon(
              //         Icons.star_border,
              //         color: Theme.of(context).primaryColor,
              //         size: 16,
              //       ),
              //     ],
              //   ),
              //   backgroundColor: Theme.of(context).accentColor.withOpacity(0.9),
              //   shape: StadiumBorder(),
              // ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Text(
                    widget.listingItem.category == null
                        ? ""
                        : widget.listingItem.category,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.body2),
              ),
            ],
          ),
        ),
        Column(
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
                  'ABOUT',
                  style: Theme.of(context).textTheme.display1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(widget.listingItem.description == null
                  ? ""
                  : widget.listingItem.description),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                "FACILITIES : ",
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  children: _facility,
                )),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                "TIME :",
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Table(
                  children: _tblData,
                ))
          ],
        ),

Row(
  mainAxisAlignment: MainAxisAlignment.end,
  crossAxisAlignment: CrossAxisAlignment.end,
  children: <Widget>[
        FloatingActionButton(onPressed: (){
    
       Share.share("https://daangor.com/general/%20/"+widget.listingItem.code);
    
    },
    
    child: Icon(Icons.share),),
  ],
),


          // Center(
          //   child: Container(
          //             width: MediaQuery.of(context).size.width * 0.4,
          //             child: RaisedButton(
          //               color: Theme.of(context).accentColor,
          //               onPressed: ()  async {
          //           Share.share("https://daangor.com/general/%20/"+widget.listingItem.code);
          //               },
          //               child: Text(
          //                 'SHARE',
          //                 style: Theme.of(context).textTheme.title.merge(
          //                       TextStyle(color: Theme.of(context).primaryColor),
          //                     ),
          //               ),
          //             )),
          // ),




        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        //   child: SizedBox(
        //     height: 180,
        //     width: double.maxFinite,
        //     child: Container(
        //       decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(6.0),
        //           image: DecorationImage(
        //             image: AssetImage('img/gps.png'),
        //             fit: BoxFit.cover,
        //           )),
        //     ),
        //   ),
        // ),

        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        //   child: ListTile(
        //     dense: true,
        //     contentPadding: EdgeInsets.symmetric(vertical: 0),
        //     leading: Icon(
        //       UiIcons.box,
        //       color: Theme.of(context).hintColor,
        //     ),
        //     title: Text(
        //       'Related',
        //       style: Theme.of(context).textTheme.display1,
        //     ),
        //   ),
        // ),
        // PopularLocationCarouselWidget(
        //     heroTag: 'product_related_products', utilitiesList: widget._productsList.popularList),
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
  ProductColorsList _productColorsList = new ProductColorsList();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(_productColorsList.list.length, (index) {
        var _color = _productColorsList.list.elementAt(index);
        return buildColor(_color);
      }),
    );
  }

  SizedBox buildColor(ProductColor color) {
    return SizedBox(
      width: 38,
      height: 38,
      child: FilterChip(
        label: Text(''),
        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
        backgroundColor: color.color,
        selectedColor: color.color,
        selected: color.selected,
        shape: StadiumBorder(),
        avatar: Text(''),
        onSelected: (bool value) {
          setState(() {
            color.selected = value;
          });
        },
      ),
    );
  }
}
