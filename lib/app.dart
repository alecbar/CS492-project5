import 'package:flutter/material.dart';
import 'screens/list-screen.dart';
import 'screens/detail-screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wasteagram',
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => ListScreen(),
        '/details': (context) => DetailScreen()
      },
    );
  }
}
