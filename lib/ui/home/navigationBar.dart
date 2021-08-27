import 'package:flutter/material.dart';
import 'package:flutterappleman/constants/Mystyle.dart';

import 'home.dart';
import '../profile/profile.dart';

class NavigationBar extends StatefulWidget {
  NavigationBar({Key? key}) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _selectedIndex = 0;
  List<Widget> _pageWidget = <Widget>[Home(), Profile()];

  List<BottomNavigationBarItem> _menuBar = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(
        Icons.date_range,
        color: Colors.white,
      ),
      label: (''),
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.person,
        color: Colors.white,
      ),
      label: (''),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageWidget.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: _menuBar,
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
        backgroundColor: MyStyle().redyColor,
        iconSize: 35,
      ),
    );
  }
}
