import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/Screen/search.dart';
import 'package:hive_test/Screen/about.dart';
import 'package:hive_test/Screen/settings.dart';
import 'package:hive_test/launcher.dart';
import 'Help/starwars_repo.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PeopleAdapter());
  await Hive.openBox('starwars');
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StarWars List',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Scaffold(
        body: launcher(),
      ),
      routes: {
        '/launcher': (context) => launcher(),
        '/search': (context) => search(),
        '/about': (context) => about(),
        '/settings': (context) => settings(),
      },
    );
  }
}
