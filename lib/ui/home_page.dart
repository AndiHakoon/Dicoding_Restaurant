import 'package:flutter/material.dart';
import 'package:restaurant2/ui/favorite_page.dart';
import 'package:restaurant2/ui/list_page.dart';
import 'package:restaurant2/ui/settings_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;

  final List<BottomNavigationBarItem> _navigationBarItem = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: "Home",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite_border),
      activeIcon: Icon(Icons.favorite),
      label: "Favorite",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings_outlined),
      activeIcon: Icon(Icons.settings),
      label: "Settings",
    ),
  ];

  final List<Widget> _listWidget = [
    const ListPage(),
    const FavoritePage(),
    const SettingsPage(),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: const Key("home_page"),
      extendBody: true,
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _navigationBarItem,
        currentIndex: _bottomNavIndex,
        onTap: _onBottomNavTapped,
      ),
    ));
  }
}
