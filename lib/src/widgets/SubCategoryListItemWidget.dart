import 'dart:convert';

import 'package:daangor/config/ui_icons.dart';
import 'package:daangor/src/models/category_model.dart';
import 'package:daangor/src/models/listing.dart';
import 'package:daangor/src/models/utilities.dart';
import 'package:daangor/src/models/route_argument.dart';
import 'package:daangor/src/util/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SubCategoryListItemWidget extends StatefulWidget {
  String heroTag;
  CategoryModel categoryModel;
  VoidCallback onDismissed;

  SubCategoryListItemWidget(
      {Key key, this.heroTag, this.categoryModel, this.onDismissed})
      : super(key: key);

  @override
  _SubCategoryListItemWidgetState createState() =>
      _SubCategoryListItemWidgetState();
}

class _SubCategoryListItemWidgetState extends State<SubCategoryListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(this.widget.categoryModel.hashCode.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              UiIcons.trash,
              color: Colors.white,
            ),
          ),
        ),
      ),
      onDismissed: (direction) {
        // Remove the item from the data source.
        setState(() {
          widget.onDismissed();
        });

        // Then show a snackbar.
        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(
                "The ${widget.categoryModel.name} Category is removed from wish list")));
      },
      child: InkWell(
        splashColor: Theme.of(context).accentColor,
        focusColor: Theme.of(context).accentColor,
        highlightColor: Theme.of(context).primaryColor,
        onTap: () {
          Navigator.of(context)
              .pushNamed('/CategoriesItem', arguments: int.parse(widget.categoryModel.id));
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.9),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).focusColor.withOpacity(0.1),
                  blurRadius: 5,
                  offset: Offset(0, 2)),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Hero(
                tag: widget.heroTag + widget.categoryModel.id,
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(
                        image: NetworkImage(widget.categoryModel.imageURL),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(width: 15),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.categoryModel.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.subhead,
                          ),
                          // Row(
                          //   children: <Widget>[
                          //     // The title of the utilitie
                          //     Icon(
                          //       Icons.star,
                          //       color: Colors.amber,
                          //       size: 18,
                          //     ),
                          //     SizedBox(
                          //       width: 4,
                          //     ),
                          //     Text(
                          //       widget.utilitie.rate.toString(),
                          //       style: Theme.of(context).textTheme.body2,
                          //     )
                          //   ],
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          // ),
                        ],
                      ),
                    ),
                    // SizedBox(width: 8),
                    // Text('${widget.utilitie.available} viewers',
                    //     style: Theme.of(context).textTheme.display1),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
