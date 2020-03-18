import 'package:daangor/src/models/category_model.dart';
import 'package:daangor/src/models/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:daangor/src/models/utilities.dart';

class CategoryGridItemWidget extends StatelessWidget {
  const CategoryGridItemWidget({
    Key key,
    @required this.categoryModel,
    @required this.heroTag,
  }) : super(key: key);

  final CategoryModel categoryModel;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      onTap: () {
        // Navigator.of(context).pushNamed('/Utilities',
        //     arguments: new RouteArgument(argumentsList: [this.utilitie, this.heroTag], id: this.utilitie.id));
      },
      child: Container(
        //margin: EdgeInsets.all(20),
        //alignment: AlignmentDirectional.topCenter,
        //padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.10), offset: Offset(0, 4), blurRadius: 10)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: this.heroTag + categoryModel.id,
              child: Image.network(categoryModel.imageURL),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                categoryModel.name,
                style: Theme.of(context).textTheme.body2,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 15),
            //   child: Text(
            //     '${utilitie.available} Viewers',
            //     style: Theme.of(context).textTheme.display1,
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 15),
            //   child: Row(
            //     children: <Widget>[
            //       // The title of the product
            //       Expanded(
            //         child: Text(
            //           '',
            //           style: Theme.of(context).textTheme.body1,
            //           overflow: TextOverflow.fade,
            //           softWrap: false,
            //         ),
            //       ),
            //       Icon(
            //         Icons.star,
            //         color: Colors.amber,
            //         size: 18,
            //       ),
            //       SizedBox(width: 2,),
            //       Text(
            //         utilitie.rate.toString(),
            //         style: Theme.of(context).textTheme.body2,
            //       )
            //     ],
                
            //   ),
            // ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
