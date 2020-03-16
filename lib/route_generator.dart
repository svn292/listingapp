import 'package:daangor/src/screens/categoriesNW.dart';
import 'package:flutter/material.dart';
import 'package:daangor/src/models/route_argument.dart';
import 'package:daangor/src/screens/Categorie.dart';
import 'package:daangor/src/screens/Categories.dart';
import 'package:daangor/src/screens/languages.dart';
import 'package:daangor/src/screens/on_boarding.dart';
import 'package:daangor/src/screens/signin.dart';
import 'package:daangor/src/screens/signup.dart';
import 'package:daangor/src/screens/splashScreen.dart';
import 'package:daangor/src/screens/tabs.dart';
import 'package:daangor/src/screens/utilitie.dart';

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
        return MaterialPageRoute(
            builder: (_) => TabsWidget(
                  currentTab: args,
                ));
      case '/Utilities':
        return MaterialPageRoute(
            builder: (_) => UtilitieWidget(
                  routeArgument: args as RouteArgument,
                ));
      case '/Languages':
        return MaterialPageRoute(builder: (_) => LanguagesWidget());
      case '/Categories':
        return MaterialPageRoute(builder: (_) => CategoriesWidget());
      case '/Categorie':
        return MaterialPageRoute(builder: (_) => FavoritesWidget());
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
