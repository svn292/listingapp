import 'dart:convert';

import 'package:daangor/src/models/CategoryItem.dart';
import 'package:daangor/src/providers/data_provider.dart';
import 'package:daangor/src/util/constants.dart';
import 'package:daangor/src/widgets/SearchBarWidget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class CategoriesWidget extends StatefulWidget {
  @override
  _CategoriesWidgetState createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  List<Widget> categoryItemsList = [];
  bool isLoading = false;
  Future<List<CategoryItem>> futureList;

  @override
  void initState() {
    futureList = getCategoriesData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Column(
        children: [
          SearchBarWidget(),
          Expanded(
            child: FutureBuilder<List<CategoryItem>>(
              future: futureList,
              builder: (_, AsyncSnapshot<List<CategoryItem>> snapshot) {
                if (snapshot.hasData) {
                  return GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(
                      snapshot.data.length,
                      (index) => InkWell(
                        onTap: () {
                          Provider.of<DataProvider>(context, listen: false).setCategoryItem(snapshot.data[index]);
                          Navigator.of(context).pushNamed('/SubCategory', arguments: int.parse(snapshot.data[index].id));
                        },
                        child: Stack(
                          alignment: AlignmentDirectional.topCenter,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(10),
                              alignment: AlignmentDirectional.topCenter,
                              padding: EdgeInsets.all(20),
                              width: double.infinity,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context).hintColor.withOpacity(0.10), offset: Offset(0, 4), blurRadius: 10)
                                ],
                                gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    Colors.white,
                                    Colors.cyan,
                                  ],
                                ),
                              ),
                              child: Hero(
                                tag: snapshot.data[index].id,
                                child: new Icon(
                                  IconDataSolid(int.parse(snapshot.data[index].iconUnicode)),
                                  color: Theme.of(context).primaryColor,
                                  size: 35,
                                ),
                              ),
                            ),
                            Positioned(
                              right: -50,
                              bottom: -100,
                              child: Container(
                                width: 220,
                                height: 220,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(150),
                                ),
                              ),
                            ),
                            Positioned(
                              left: -30,
                              top: -60,
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(150),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 80, bottom: 10),
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Center(
                                    child: Text(
                                      snapshot.data[index].name,
                                      style: Theme.of(context).textTheme.body2,
                                      maxLines: 1,
                                      softWrap: false,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),

                                  // Row(
                                  //   children: <Widget>[
                                  //     // The title of the product
                                  //     Expanded(
                                  //       child: Text(
                                  //         '${category.utilities.length} Items',
                                  //         style: Theme.of(context).textTheme.body1,
                                  //         overflow: TextOverflow.fade,
                                  //         softWrap: false,
                                  //       ),
                                  //     ),
                                  //     Icon(
                                  //       Icons.star,
                                  //       color: Colors.amber,
                                  //       size: 18,
                                  //     ),
                                  //   ],
                                  //   crossAxisAlignment: CrossAxisAlignment.center,
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Future<List<CategoryItem>> getCategoriesData() async {
    setState(() {
      isLoading = true;
    });

    var response = await Dio().post('$BASEURL/getallcategory');
    print(response.data);
    List<CategoryItem> categoryItemData = (json.decode(response.data) as List).map((i) => CategoryItem.fromJson(i)).toList();

    setState(() {
      isLoading = false;
    });

    return categoryItemData;
  }
}

//ListTile(
//title: Text(
//'${snapshot.data[index].name}',
//style: Theme.of(context).textTheme.headline5,
//),
//subtitle: Icon(IconDataSolid(int.parse(snapshot.data[index].iconUnicode))),
//)
