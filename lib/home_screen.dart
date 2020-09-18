import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:national_train_hunter/constants/text_constants.dart';
import 'package:national_train_hunter/page/favourites_page.dart';
import 'package:national_train_hunter/page/live_trains_page.dart';
import 'package:national_train_hunter/page/planner_page.dart';
import 'package:national_train_hunter/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageOptions = [
    // MyTravelPage(),
    LiveTrainsPage(),
    PlannerPage(),
    FavouritesPage(),
  ];

  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kAppName),
        actions: <Widget>[
          IconButton(
            key: Key('icon_button_settings'),
            icon: Icon(
              Icons.settings,
            ),
            tooltip: 'Settings',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedPage,
        children: _pageOptions,
      ),
      extendBody: true,
      bottomNavigationBar: FloatingNavbar(
        key: Key('bottom_navigation_bar'),
        backgroundColor: Theme.of(context).accentColor,
        items: <FloatingNavbarItem>[
          // FloatingNavbarItem(
          //   icon: Icons.person,
          //   title: 'My Travel',
          // ),
          FloatingNavbarItem(
            icon: Icons.access_time,
            title: 'Live Trains',
          ),
          FloatingNavbarItem(
            icon: Icons.train,
            title: 'Planner',
          ),
          FloatingNavbarItem(
            icon: Icons.favorite,
            title: 'Favourites',
          ),
        ],
        currentIndex: _selectedPage,
        onTap: (int index) {
          setState(() {
            _selectedPage = index;
          });
          return index;
        },
      ),
    );
  }
}
