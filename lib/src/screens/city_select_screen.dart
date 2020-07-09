import 'dart:convert';

import 'package:daangor/src/models/city_model.dart';
import 'package:daangor/src/providers/data_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class CitySelectScreen extends StatefulWidget {
  static const String id = 'CitySelectScreen';
  static const CityModel cityModel = null;

  @override
  _CitySelectScreenState createState() => _CitySelectScreenState();
}

class _CitySelectScreenState extends State<CitySelectScreen> {
  Future<List<CityModel>> cityModelsList;
  bool isLoading = true;

  @override
  void initState() {
    cityModelsList = loadCitiesApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select city'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Container(
          child: FutureBuilder(
            future: cityModelsList,
            builder: (BuildContext context, AsyncSnapshot<List<CityModel>> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Text(
                      'Tap to select city',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                context.read<DataProvider>().changeCityModel(snapshot.data[index]);
                                Navigator.pop(context,snapshot.data[index]);
                              },
                              child: ListTile(
                                title: Text(snapshot.data[index].name),
                              ),
                            );
                          }),
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Future<List<CityModel>> loadCitiesApi() async {
    var response = await Dio().get('https://daangor.com/api/getCity');
    List<CityModel> cityModelsList = (json.decode(response.data) as List).map((i) => CityModel.fromJson(i)).toList();

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }

    return cityModelsList;
  }
}
