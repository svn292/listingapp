import 'package:daangor/src/models/CategoryItem.dart';
import 'package:flutter/foundation.dart';

class DataProvider with ChangeNotifier, DiagnosticableTreeMixin {
  String userToken = '';
  CategoryItem _categoryItem = CategoryItem();

  setCategoryItem(CategoryItem categoryItem) {
    _categoryItem = categoryItem;
  }

  CategoryItem getCategoryItem() {
    return _categoryItem;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('userToken', userToken));
  }
}
