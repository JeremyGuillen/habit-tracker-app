import 'package:habit_tracker/widgets/bottomnavigationbar.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/widgets/tab_navigator.dart';

enum TabItem { home, signin, habits }

const Map<TabItem, String> tabName = {
  TabItem.home: 'Home',
  TabItem.signin: 'Signin',
  TabItem.habits: 'Habits',
};

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  var _currentTab = TabItem.signin;
  final _navigatorKeys = {
    TabItem.signin: GlobalKey<NavigatorState>(),
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.habits: GlobalKey<NavigatorState>(),
  };

  void _selectedTab(TabItem tabItem) {
    setState(() {
      _currentTab = tabItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await _navigatorKeys[_currentTab]!.currentState!.maybePop(),
      child: Scaffold(
        body: Stack(children: [
          _buildOffstageNavigator(TabItem.signin),
          _buildOffstageNavigator(TabItem.home),
          _buildOffstageNavigator(TabItem.habits),
        ]),
        bottomNavigationBar: Visibility(
          visible: true,
          child: BottomNavigation(
            currentTab: _currentTab,
            onSelectTab: _selectedTab,
          ),
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }
}
