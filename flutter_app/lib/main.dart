/*
 * Name: GGC Student Picker
 * Date: Nov 15, 2020
 * Author: Anne Joseph
 * Course Name: ITEC 4550 - Mobile App Development
 */

import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'GGC Thorns, Roses and Buds'),
    );
  }
}
