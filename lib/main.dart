import 'package:flutter/material.dart';
import 'package:faith_pad_test/screens/home_screen.dart';

void main() {
  runApp(ChurchApp());
}

class ChurchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChurchApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
