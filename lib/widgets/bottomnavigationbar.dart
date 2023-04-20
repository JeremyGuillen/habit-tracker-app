import 'package:flutter/material.dart';

import '../app.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation(
      {super.key, required this.currentTab, required this.onSelectTab});
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(TabItem.home),
        _buildItem(TabItem.habits),
      ],
      onTap: (index) => onSelectTab(TabItem.values[index]),
    );
  }

  BottomNavigationBarItem _buildItem(TabItem item) {
    return BottomNavigationBarItem(
        icon: Icon(Icons.layers, color: Colors.black), label: tabName[item]);
  }
}
