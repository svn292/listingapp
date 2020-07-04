import 'package:daangor/src/screens/Categories.dart';
import 'package:daangor/src/screens/WebViewScreen.dart';
import 'package:daangor/src/screens/ads.dart';
import 'package:daangor/src/screens/categoriesNW.dart';
import 'package:daangor/src/screens/get_form_user.dart';
import 'package:daangor/src/screens/languages.dart';
import 'package:daangor/src/screens/search.dart';
import 'package:daangor/src/screens/signin.dart';
import 'package:daangor/src/screens/signup.dart';
import 'package:daangor/src/screens/splashScreen.dart';
import 'package:daangor/src/screens/subCategory.dart';
import 'package:daangor/src/screens/tabs.dart';
import 'package:daangor/src/screens/utilitie.dart';
import 'package:flutter/material.dart';

import 'src/screens/favorites.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Splash());
      case '/SignIn':
        return MaterialPageRoute(builder: (_) => SignInWidget());
      case '/SignUp':
        return MaterialPageRoute(builder: (_) => SignUpWidget());
      case '/Tabs':
        return MaterialPageRoute(builder: (_) => TabsWidget(currentTab: args));
      case '/Utilities':
        return MaterialPageRoute(builder: (_) => UtilitieWidget(args));
      case '/Search':
        return MaterialPageRoute(builder: (_) => Search(args));
      case '/Ads':
        return MaterialPageRoute(builder: (_) => Ads());
      case '/Languages':
        return MaterialPageRoute(builder: (_) => LanguagesWidget());
      case '/Categories':
        return MaterialPageRoute(builder: (_) => CategoriesWidget());
      case '/CategoriesItem':
        return MaterialPageRoute(builder: (_) => CategoriesNew(args));
      case '/SubCategory':
        return MaterialPageRoute(builder: (_) => SubCat(args));
      case '/Categorie':
        return MaterialPageRoute(builder: (_) => FavoritesWidget());
      case '/GetFormUser':
        return MaterialPageRoute(builder: (_) => GetFormUser());
      case '/HelpScreen':
        return MaterialPageRoute(builder: (_) => WebViewScreen(args));
      // case '/Categorie':
      //   return MaterialPageRoute(builder: (_) => CategorieWidget(routeArgument: args as  RouteArgument,));

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
