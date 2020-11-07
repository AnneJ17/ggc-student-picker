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
  final _suggestions = <WordPair>[];
  final _biggerFont = TextStyle(fontSize: 18.0);

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
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddNamePage()));
        break;
      case Constants.sort:
        _suggestions.sort((a, b) => a.toString().compareTo(b.toString()));
        break;
      case Constants.shuffle:
        _suggestions.shuffle();
        break;
      case Constants.clear:
        _suggestions.clear();
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
        itemCount: _suggestions.length,
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
          return Dismissible(
            background: stackBehindDismiss(),
            key: ObjectKey(_suggestions[index]),
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Text(
                _suggestions[index].asPascalCase,
                textScaleFactor: 1.3,
              ),
            ),
            onDismissed: (direction) {
              var item = _suggestions.elementAt(index);
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
      _suggestions.removeAt(index);
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
}
