import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_app/about.dart';
import 'package:flutter_app/name.dart';
import 'package:flutter_app/send_receive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key key, @required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _suggestions = <WordPair>[];
  List<String> words = new List();
  final prefs = SharedPreferences.getInstance();

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
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  _suggestions.addAll(generateWordPairs().take(5));
                  for (var i = 0; i < 5; i++) {
                    words.add(_suggestions[i].first);
                  }
                });
              }, // handle your image tap here
              child: Image.asset('assets/bbuildingwavy.jpg'),
            ),
            Expanded(child: _buildSuggestions())
          ],
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
        _awaitReturnValueFromSecondScreen(context);
        break;
      case Constants.sort:
        words.sort((a, b) => a.toString().compareTo(b.toString()));
        break;
      case Constants.shuffle:
        words.shuffle();
        break;
      case Constants.clear:
        words.clear();
        break;
      case Constants.about:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AboutPage()));
        break;
    }
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(26.0),
        itemCount: words.length,
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
          writeState();
          return Dismissible(
            background: stackBehindDismiss(),
            key: ObjectKey(words[index]),
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Text(
                words[index],
                textScaleFactor: 1.3,
              ),
            ),
            onDismissed: (direction) {
              var item = words.elementAt(index);
              //To delete
              deleteItem(index);
              //To show a snackbar when item is deleted
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("$item deleted"),
              ));
            },
          );
        });
  }

  void deleteItem(index) {
    setState(() {
      words.removeAt(index);
    });
  }

  Widget stackBehindDismiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  void _awaitReturnValueFromSecondScreen(BuildContext context) async {
    // starts the AddNamePage and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddNamePage(),
        ));

    // after the SecondScreen result comes back update the list view
    setState(() {
      words.add(result);
    });
  }

  /// Adding a list
  @override
  void writeState() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    await prefs.setStringList("MyList", words);
  }

  // writing data
  @override
  Future<List<String>> readState() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getStringList("MyList");
  }
}
