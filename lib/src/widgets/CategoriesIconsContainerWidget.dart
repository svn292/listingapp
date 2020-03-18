import 'package:daangor/src/models/category.dart';
import 'package:daangor/src/models/route_argument.dart';
import 'package:daangor/src/widgets/CategoryIconWidget.dart';
import 'package:flutter/material.dart';

class CategoriesIconsContainerWidget extends StatefulWidget {
  CategoriesIconsContainerWidget(
      {Key key, @required CategoriesList categoriesList, this.onPressed})
      : super(key: key);

  final ValueChanged<String> onPressed;

  @override
  _CategoriesIconsContainertState createState() =>
      _CategoriesIconsContainertState();
}

class _CategoriesIconsContainertState
    extends State<CategoriesIconsContainerWidget> {
  CategoriesList categoriesList = new CategoriesList();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: _buildSuggestions(categoriesList.list, context)),
    );
  }
}

_buildSuggestions(List<Category> list, BuildContext context) {
  List<Widget> categories = List();
  for(var i=0;i<list.length;i++){
  // list.forEach((item) {
    categories.add(
      Container(
        padding: EdgeInsets.only(bottom: 20),
        child: CategoryIconWidget(
          category: list.elementAt(i),
          onPressed: (id) {
            // print("FFFFFFFFFFFFF :: " + id);
            Navigator.of(context).pushNamed('/CategoriesItem', arguments: i+1);
          },
        ),
      ),
    );
  };
  return categories;
}
