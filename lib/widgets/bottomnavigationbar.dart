import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigation();
}

enum Routes { home, habits }

Map<Routes, String> routesNames = {
  Routes.home: '/home',
  Routes.habits: '/habits',
};

class _BottomNavigation extends State<BottomNavigation> {
  int selectedItem = 0;
  void _onItemTapped(int index) {
    setState(() {
      selectedItem = index;
    });
    Routes route = Routes.values[index];
    String routePath = routesNames[route]!;
    GoRouter.of(context).go(routePath);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.note_add),
          label: "Habits",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ],
      onTap: _onItemTapped,
      currentIndex: selectedItem,
    );
  }
}
