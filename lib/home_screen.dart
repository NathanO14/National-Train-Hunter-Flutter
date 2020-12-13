import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:national_train_hunter/page/favourites_page.dart';
import 'package:national_train_hunter/page/live_trains_page.dart';
import 'package:national_train_hunter/page/planner_page.dart';
import 'package:national_train_hunter/screens/home/navigator_page.dart';

class LayoutConfig {
  List<Widget> pageOptions;
  List<FloatingNavbarItem> floatingNavbarItems;
  int selectedPage;

  LayoutConfig({
    this.pageOptions,
    this.floatingNavbarItems,
    this.selectedPage,
  });
}

Map<int, GlobalKey<NavigatorState>> _navigatorKeys = {
  0: GlobalKey(),
  1: GlobalKey(),
  2: GlobalKey(),
};

Map<String, LayoutConfig> homeLayoutConfig = {
  'mobile': LayoutConfig(
    pageOptions: [
      NavigatorPage(
        navigatorKey: _navigatorKeys[0],
        child: PlannerPage(),
      ),
      NavigatorPage(
        navigatorKey: _navigatorKeys[1],
        child: LiveTrainsPage(),
      ),
      NavigatorPage(
        navigatorKey: _navigatorKeys[2],
        child: FavouritesPage(),
      ),
    ],
    floatingNavbarItems: <FloatingNavbarItem>[
      FloatingNavbarItem(
        icon: Icons.train_rounded,
        title: 'Planner',
      ),
      FloatingNavbarItem(
        icon: Icons.access_time_rounded,
        title: 'Live Trains',
      ),
      FloatingNavbarItem(
        icon: Icons.favorite_rounded,
        title: 'Favourites',
      ),
    ],
    selectedPage: 1,
  ),
};

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPage;
  LayoutConfig _layoutConfig;
  List<Widget> _pageOptions;

  @override
  void initState() {
    super.initState();
    _setUpConfig();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: getIndexedStack(),
        extendBody: true,
        bottomNavigationBar: FloatingNavbar(
          key: Key('bottom_navigation_bar'),
          backgroundColor: Theme.of(context).accentColor,
          borderRadius: 30.0,
          itemBorderRadius: 30.0,
          fontSize: 9.0,
          iconSize: 20.0,
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          padding: const EdgeInsets.only(bottom: 5, top: 5),
          items: _layoutConfig.floatingNavbarItems,
          currentIndex: _selectedPage,
          onTap: navigatorOnTap,
        ),
      ),
    );
  }

  int navigatorOnTap(int index) {
    if (_selectedPage == index) {
      _navigatorKeys[index].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _selectedPage = index;
      });
    }

    return index;
  }

  Widget getIndexedStack() {
    return WillPopScope(
      onWillPop: () async {
        return !await Navigator.maybePop(
          _navigatorKeys[_selectedPage].currentState.context,
        );
      },
      child: IndexedStack(
        index: _selectedPage,
        children: _pageOptions,
      ),
    );
  }

  void _setUpConfig() {
    _layoutConfig = getLayoutConfig();
    _pageOptions = _layoutConfig.pageOptions;
    _selectedPage = _layoutConfig.selectedPage;
  }

  LayoutConfig getLayoutConfig() {
    return kIsWeb ? homeLayoutConfig['web'] : homeLayoutConfig['mobile'];
  }
}
