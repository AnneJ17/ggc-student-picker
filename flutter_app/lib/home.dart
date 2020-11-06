import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_app/about.dart';
import 'package:flutter_app/name.dart';
import 'package:flutter_app/send_receive.dart';

import 'constants.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Text('GGC Thorns, Roses and Buds'), actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String result) {
              setState(() {
                choiceAction(result);
              });
            },
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ]),
        body: Column(
          children: <Widget>[Image.asset('assets/bbuildingwavy.jpg')],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.autorenew),
          backgroundColor: Colors.green,
          onPressed: () {},
        ));
  }

  void choiceAction(String choice) {
    switch (choice) {
      case Constants.sendReceive:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SendReceivePage()));
        break;
      case Constants.addName:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddNamePage()));
        break;
      case Constants.sort:
        print("Sort");
        break;
      case Constants.shuffle:
        print("Shuffle");
        break;
      case Constants.clear:
        print("Clear");
        break;
      case Constants.about:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AboutPage()));
        break;
    }
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return Text(wordPair.asPascalCase);
  }
}
