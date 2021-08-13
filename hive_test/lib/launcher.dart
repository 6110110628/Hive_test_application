import 'package:flutter/material.dart';
import 'package:hive_test/Screen/home.dart';
import 'package:hive_test/Screen/search.dart';
import 'package:hive_test/Screen/about.dart';
import 'package:hive_test/Screen/settings.dart';

class launcher extends StatefulWidget {
  const launcher({Key? key}) : super(key: key);

  @override
  _launcherState createState() => _launcherState();
}

class _launcherState extends State<launcher> {
  int _currentIndex = 0;
  List<Widget> _pageWidget = <Widget>[
    home(),
    search(),
    settings(),
    about(),
  ];
  List<BottomNavigationBarItem> _menuBar = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: 'Search',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.error),
      label: 'About',
    ),
  ];
  void _onTapBottomAppBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: _pageWidget.elementAt(_currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: _menuBar,
          currentIndex: _currentIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          onTap: _onTapBottomAppBar,
        ),
      ),
    );
  }
}
