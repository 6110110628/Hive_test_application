import 'package:flutter/material.dart';
import 'package:hive_test/Screen/starwars_list.dart';

// ignore: camel_case_types
class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);
  //static const routeName = '/home';

  @override
  _homeState createState() => _homeState();
}

// ignore: camel_case_types
class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StarWars'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pushNamed(context, '/launcher');
              },
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Search'),
              onTap: () {
                Navigator.pushNamed(context, '/search');
              },
            ),
            ListTile(
              leading: Icon(Icons.error),
              title: Text('Settings'),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('About'),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
          ],
        ),
      ),
      body: StarwarsList(),
    );
  }
}
