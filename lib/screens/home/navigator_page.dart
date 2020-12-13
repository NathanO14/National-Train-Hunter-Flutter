import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:national_train_hunter/constants/text_constants.dart';
import 'package:national_train_hunter/layout/route/animated_route.dart';
import 'package:national_train_hunter/settings_screen.dart';

class NavigatorPage extends StatefulWidget {
  final Widget child;
  final GlobalKey<NavigatorState> navigatorKey;

  NavigatorPage({
    this.child,
    this.navigatorKey,
  });

  @override
  _NavigatorPageState createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget.navigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return createAnimatedRoute(
          Scaffold(
            appBar: AppBar(
              title: Text(kAppName),
              actions: _getActions(context),
            ),
            body: widget.child,
          ),
          routeSettings: settings,
        );
      },
    );
  }

  List<Widget> _getActions(BuildContext context) {
    return !kIsWeb
        ? <Widget>[
            IconButton(
              key: Key('icon_button_settings'),
              icon: Icon(
                Icons.settings,
                size: 25.0,
              ),
              tooltip: 'Settings',
              onPressed: () {
                Navigator.push(context, createAnimatedRoute(SettingsScreen()));
              },
            ),
          ]
        : [];
  }
}
