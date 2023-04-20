import 'package:flutter/material.dart';
import 'package:habit_tracker/screens/home.dart';

import '../app.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String createHabit = '/create_habit';
  static const String editHabit = '/edit_habit';

  static String getRoute(String url) {
    switch (url) {
      case '/':
        {
          return root;
        }
      case 'create_habit':
        {
          return createHabit;
        }
      case 'edit_habit':
        {
          return editHabit;
        }
      default:
        {
          return root;
        }
    }
  }
}

class TabNavigator extends StatelessWidget {
  const TabNavigator(
      {super.key, required this.navigatorKey, required this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      TabNavigatorRoutes.createHabit: (context) => Home(),
      TabNavigatorRoutes.root: (context) => Home(),
      TabNavigatorRoutes.editHabit: (context) => Home(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name]!(context),
        );
      },
    );
  }

  void _push(BuildContext context, String url) {
    var routeBuilders = _routeBuilders(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            routeBuilders[TabNavigatorRoutes.getRoute(url)]!(context),
      ),
    );
  }
}
