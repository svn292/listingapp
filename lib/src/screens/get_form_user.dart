import 'dart:convert';

import 'package:daangor/config/ui_icons.dart';
import 'package:daangor/src/models/CategoryItem.dart';
import 'package:daangor/src/models/add_new_listing_model.dart';
import 'package:daangor/src/widgets/text_widget.dart';
import 'package:daangor/src/widgets/user_info_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetFormUser extends StatefulWidget {
  static String id = '/GetFormUser';

  @override
  _GetFormUserState createState() => _GetFormUserState();
}

class _GetFormUserState extends State<GetFormUser> {
  List<CategoryItem> categoryItemsList = [];
  CategoryItem categorySelectedItem;
  AddNewListingModel _addNewListingModel = AddNewListingModel();
  FeaturedCharacter _character = FeaturedCharacter.isFeatured;
  bool isLoading = false;
  String dropdownCityValue = 'Delhi';
  String dropdownVideoValue = 'YouTube';

  @override
  void initState() {
    super.initState();
    getCategoriesData();
    // categoryItemsList.add(CategoryItem(name: 'No items'));
    // categorySelectedItem = categoryItemsList[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Listing Form'),
        leading: IconButton(
          icon: Icon(UiIcons.return_icon, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                UserInfoWidget(
                  title: 'Title',
                  function: (value) {
                    _addNewListingModel.title = value;
                  },
                ),
                UserInfoWidget(
                  title: 'Description',
                  function: (value) {
                    _addNewListingModel.description = value;
                  },
                  lines: 3,
                ),
                TextWidget(
                  text: 'Featured Type',
                  textSize: 18,
                ),
                Column(
                  children: [
                    ListTile(
                      title: TextWidget(
                        text: 'Featured',
                        textSize: 18,
                      ),
                      leading: Radio(
                        value: FeaturedCharacter.isFeatured,
                        groupValue: _character,
                        onChanged: (FeaturedCharacter value) {
                          setState(() {
                            _character = value;
                            _addNewListingModel.is_featured = 0;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: TextWidget(
                        text: 'None Featured',
                        color: Colors.black,
                        textSize: 18,
                      ),
                      leading: Radio(
                        value: FeaturedCharacter.isNotFeatured,
                        groupValue: _character,
                        onChanged: (FeaturedCharacter value) {
                          setState(() {
                            _character = value;
                            _addNewListingModel.is_featured = 1;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                UserInfoWidget(
                  title: 'Google Analytics Id',
                  function: (value) {
                    _addNewListingModel.description = value;
                  },
                ),
                TextWidget(
                  text: 'Category',
                  margin: EdgeInsets.only(top: 10),
                  textSize: 18,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.only(left: 8, right: 8),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1.0, style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: StatefulBuilder(
                      builder: (BuildContext context,
                          void Function(void Function()) setState) {
                        return DropdownButton<CategoryItem>(
                          isExpanded: true,
                          value: categorySelectedItem,
                          onChanged: (CategoryItem newValue) {
                            setState(() {
                              categorySelectedItem = newValue;
                              _addNewListingModel.categories =
                                  int.parse(categorySelectedItem.id);

                              print(_addNewListingModel.categories);
                            });
                          },
                          items: categoryItemsList
                              .map<DropdownMenuItem<CategoryItem>>(
                                  (CategoryItem value) {
                            return DropdownMenuItem<CategoryItem>(
                              value: value,
                              child: Text(value.name),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.only(left: 8, right: 8),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1.0, style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: dropdownCityValue,
                      isExpanded: true,
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownCityValue = newValue;
                        });
                      },
                      items: <String>['Delhi', 'guwahati']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                UserInfoWidget(
                  title: 'Address',
                  lines: 3,
                  function: (value) {
                    _addNewListingModel.address = value;
                  },
                ),
                UserInfoWidget(
                  title: 'Latitude',
                  function: (value) {
                    _addNewListingModel.latitude = value;
                  },
                ),
                UserInfoWidget(
                  title: 'Longitude',
                  function: (value) {
                    _addNewListingModel.longitude = value;
                  },
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.only(left: 8, right: 8),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1.0, style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: dropdownVideoValue,
                      isExpanded: true,
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownVideoValue = newValue;
                          _addNewListingModel.video_provider = newValue;
                        });
                      },
                      items: <String>['YouTube', 'Vimeo', 'HTML5']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                UserInfoWidget(
                  title: 'Video Url',
                  function: (value) {
                    _addNewListingModel.video_url = value;
                  },
                ),
                UserInfoWidget(
                  title: 'Tags',
                  function: (value) {
                    _addNewListingModel.tags = value;
                  },
                ),
                UserInfoWidget(
                  title: 'SEO Meta Tags',
                  function: (value) {
                    _addNewListingModel.seo_meta_tags = value;
                  },
                ),
                UserInfoWidget(
                  title: 'Saturday timings',
                  function: (value) {
                    _addNewListingModel.saturday = value;
                  },
                ),
                UserInfoWidget(
                  title: 'Sunday timings',
                  function: (value) {
                    _addNewListingModel.sunday = value;
                  },
                ),
                UserInfoWidget(
                  title: 'Monday timings',
                  function: (value) {
                    _addNewListingModel.monday = value;
                  },
                ),
                UserInfoWidget(
                  title: 'Tuesday timings',
                  function: (value) {
                    _addNewListingModel.tuesday = value;
                  },
                ),
                UserInfoWidget(
                  title: 'Wednesday timings',
                  function: (value) {
                    _addNewListingModel.wednesday = value;
                  },
                ),
                UserInfoWidget(
                  title: 'Thursday timings',
                  function: (value) {
                    _addNewListingModel.thursday = value;
                  },
                ),
                UserInfoWidget(
                  title: 'Friday timings',
                  function: (value) {
                    _addNewListingModel.friday = value;
                  },
                ),
                UserInfoWidget(
                  title: 'Website',
                  function: (value) {
                    _addNewListingModel.website = value;
                  },
                ),
                UserInfoWidget(
                  title: 'Email',
                  function: (value) {
                    _addNewListingModel.email = value;
                  },
                ),
                UserInfoWidget(
                  title: 'Phone Number',
                  function: (value) {
                    _addNewListingModel.phone = value;
                  },
                ),
                UserInfoWidget(
                  title: 'Facebook',
                  function: (value) {
                    _addNewListingModel.facebook = value;
                  },
                ),
                UserInfoWidget(
                  title: 'Twitter',
                  function: (value) {
                    _addNewListingModel.twitter = value;
                  },
                ),
                UserInfoWidget(
                  title: 'Linkedin',
                  function: (value) {
                    _addNewListingModel.linkedin = value;
                  },
                ),
                FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 70),
                  onPressed: () {
                    addListing();
                  },
                  child: Text(
                    'Add listing',
                    style: Theme.of(context).textTheme.title.merge(
                          TextStyle(color: Theme.of(context).primaryColor),
                        ),
                  ),
                  color: Theme.of(context).accentColor,
                  shape: StadiumBorder(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getCategoriesData() async {
    setState(() {
      isLoading = true;
    });

    var response = await Dio().post('https://daangor.com/api/getallcategory');
    List<CategoryItem> categoryItemData = (json.decode(response.data) as List)
        .map((i) => CategoryItem.fromJson(i))
        .toList();
    setState(() {
      categoryItemsList.clear();
      categoryItemsList.addAll(categoryItemData);
    });

    setState(() {
      isLoading = false;
    });
  }

  addListing() async {
    setState(() {
      isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    var formData = FormData.fromMap({
      'title': _addNewListingModel.title,
      'description': _addNewListingModel.description,
      'is_featured': _addNewListingModel.is_featured,
      'country_id': _addNewListingModel.country_id,
      'city_id': _addNewListingModel.city_id,
      'address': _addNewListingModel.address,
      'latitude': _addNewListingModel.latitude,
      'longitude': _addNewListingModel.longitude,
      'google_analytics_id': _addNewListingModel.google_analytics_id,
      'categories': _addNewListingModel.categories,
      'video_provider': _addNewListingModel.video_provider,
      'video_url': _addNewListingModel.video_url,
      'tags': _addNewListingModel.tags,
      'seo_meta_tags': _addNewListingModel.seo_meta_tags,
      'website': _addNewListingModel.website,
      'email': _addNewListingModel.email,
      'phone': _addNewListingModel.phone,
      'listing_type': _addNewListingModel.listing_type,
      'facebook': _addNewListingModel.facebook,
      'twitter': _addNewListingModel.twitter,
      'linkedin': _addNewListingModel.linkedin,
      'saturday': _addNewListingModel.saturday,
      'sunday': _addNewListingModel.sunday,
      'monday': _addNewListingModel.monday,
      'tuesday': _addNewListingModel.tuesday,
      'wednesday': _addNewListingModel.wednesday,
      'thursday': _addNewListingModel.thursday,
      'friday': _addNewListingModel.friday,
    });

    var dio = Dio();
    dio.options.headers['authorization'] = prefs.getString('token');
    var response =
        await dio.post('https://daangor.com/api/addlisting', data: formData);
    print(response.data);

    Fluttertoast.showToast(
        msg: jsonDecode(response.data)['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);

    setState(() {
      isLoading = false;
    });
  }
}

enum FeaturedCharacter { isFeatured, isNotFeatured }
