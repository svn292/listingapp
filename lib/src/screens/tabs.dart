import 'package:daangor/config/ui_icons.dart';

import 'package:daangor/src/screens/account.dart';
import 'package:daangor/src/screens/Categories.dart';
import 'package:daangor/src/screens/chat.dart';
import 'package:daangor/src/screens/favorites.dart';
import 'package:daangor/src/screens/home.dart';
import 'package:daangor/src/screens/messages.dart';
import 'package:daangor/src/screens/notifications.dart';
import 'package:daangor/src/widgets/DrawerWidget.dart';
import 'package:daangor/src/widgets/FilterWidget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TabsWidget extends StatefulWidget {
  int currentTab = 0;
  int selectedTab = 0;
  String currentTitle = 'Home';
  Widget currentPage = HomeWidget();

  TabsWidget({
    Key key,
    this.currentTab,
  }) : super(key: key);

  @override
  _TabsWidgetState createState() {
    return _TabsWidgetState();
  }
}

class _TabsWidgetState extends State<TabsWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  initState() {
    _selectTab(widget.currentTab);
    super.initState();
  }

  @override
  void didUpdateWidget(TabsWidget oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      widget.selectedTab = tabItem;
      switch (tabItem) {
        case 0:
          widget.currentTitle = 'Home';
          widget.currentPage = HomeWidget();
          break;
        case 3:
          widget.currentTitle = 'Account';
          widget.currentPage = AccountWidget();
          break;

        case 1:
          widget.currentTitle = 'Category';
          widget.currentPage = CategoriesWidget();
          break;
        case 2:
          widget.currentTitle = 'Favorites';
          widget.currentPage = FavoritesWidget();
          break;

        default:
          widget.currentTab = 1;
          widget.selectedTab = 1;
          widget.currentTitle = 'Home';
          widget.currentPage = HomeWidget();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(),
      // endDrawer: FilterWidget(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: <Widget>[
            Text(
              widget.currentTitle,
              style: Theme.of(context).textTheme.display1,
            ),
            SizedBox(width: 20,),
            Image.asset("img/dark_logo.png", width: 100,)
          ],
        ),
        actions: <Widget>[
          // Container(
          //     width: 30,
          //     height: 30,
          //     margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
          //     child: InkWell(
          //       borderRadius: BorderRadius.circular(300),
          //       onTap: () {
          //         Navigator.of(context).pushNamed('/Tabs', arguments: 1);
          //       },
          //       child: CircleAvatar(
          //         backgroundImage: AssetImage('img/user2.jpg'),
          //       ),
          //     )),
        ],
      ),
      body: Stack(
        children: <Widget>[
         
          Container(
            child: widget.currentPage,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          //  Positioned(child: Image.asset("img/dark_logo.png", width: 100,) ,top: 0,),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).accentColor,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        iconSize: 22,
        elevation: 0,
        backgroundColor: Colors.transparent,
        selectedIconTheme: IconThemeData(size: 25),
        unselectedItemColor: Theme.of(context).hintColor.withOpacity(1),
        currentIndex: widget.selectedTab,
        onTap: (int i) {
          widget.selectedTab = i;
          this._selectTab(i);
        },
        // this will be set when a new tab is tapped
        items: [
          // BottomNavigationBarItem(
          //     title: new Container(height: 5.0),
          //     icon: Container(
          //       width: 45,
          //       height: 45,
          //       decoration: BoxDecoration(
          //         color: Theme.of(context).accentColor.withOpacity(0.8),
          //         borderRadius: BorderRadius.all(
          //           Radius.circular(50),
          //         ),
          //         boxShadow: [
          //           BoxShadow(
          //               color: Theme.of(context).accentColor.withOpacity(0.4),
          //               blurRadius: 40,
          //               offset: Offset(0, 15)),
          //           BoxShadow(
          //               color: Theme.of(context).accentColor.withOpacity(0.4),
          //               blurRadius: 13,
          //               offset: Offset(0, 3))
          //         ],
          //       ),
          //       child: new Icon(UiIcons.home,
          //           color: Theme.of(context).primaryColor),
          //     )),
          BottomNavigationBarItem(
            icon: Icon(UiIcons.home),
            title: new Container(height: 0.0),
          ),
          BottomNavigationBarItem(
            icon: Icon(UiIcons.folder_1),
            // icon: ImageIcon(AssetImage("img/driver.png")),
            title: new Container(height: 0.0),
          ),

          // BottomNavigationBarItem(
          //   icon: new Icon(UiIcons.chat),
          //   title: new Container(height: 0.0),
          // ),
          BottomNavigationBarItem(
            icon: new Icon(UiIcons.heart),
            title: new Container(height: 0.0),
          ),
          BottomNavigationBarItem(
            icon: Icon(UiIcons.user_1),
            title: new Container(height: 0.0),
          ),
        ],
      ),
    );
  }
}

//  Navigator.of(context).pushNamed('/Categories');
