import 'dart:convert';

import 'package:daangor/src/models/CategoryItem.dart';
import 'package:daangor/src/models/city_model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataProvider with ChangeNotifier, DiagnosticableTreeMixin {
  String userToken = '';
  CategoryItem _categoryItem = CategoryItem();
  CityModel _selectedCity;

  setCategoryItem(CategoryItem categoryItem) {
    _categoryItem = categoryItem;
  }

  CategoryItem getCategoryItem() {
    return _categoryItem;
  }

  changeCityModel(CityModel selectedCity) async {
    _selectedCity = selectedCity;

    var prefs = await SharedPreferences.getInstance();
    prefs.setString('set_city', jsonEncode(selectedCity));
    notifyListeners();
  }

  CityModel getCityModel() {
    return _selectedCity;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('userToken', userToken));
  }
}
