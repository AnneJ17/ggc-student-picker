import 'dart:math';
import 'dart:ui';

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
  List<String> invisible = new List();
  List<String> visible = new List();
  bool show = false;
  static const iconDisplayed = Icon(Icons.visibility_off);
  final _random = new Random();

  List<String> images = [
    "assets/bud.png",
    "assets/rose.png",
    "assets/thorn.png"
  ];

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
                  })?.toList() ??
                  [];
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
                  visible.clear();
                  visibleItems();
                  writeState();
                });
              }, // handle your image tap here
              child: Image.asset('assets/bbuildingwavy.jpg'),
            ),
            if (show)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 110.0, top: 30),
                    child: Text(
                      (visible != null && visible.length > 0)
                          ? visible[_random.nextInt(visible.length)]
                          : "",
                      style: TextStyle(fontSize: 27),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 110.0, top: 30),
                    child: Image.asset(
                      (images != null && images.length > 0)
                          ? images[_random.nextInt(images.length)]
                          : "",
                      height: 50,
                    ),
                  )
                ],
              ),
            Expanded(child: _buildSuggestions())
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.autorenew),
          backgroundColor: Colors.green,
          onPressed: () {
            setState(() {
              show = true;
              images.shuffle();
            });
          },
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
        visible.clear();
        // images.clear();
        break;
      case Constants.about:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AboutPage()));
        break;
    }
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 60.0),
        itemCount: words.length,
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
          final word = words[index];
          Icon status = (invisible.contains(word) ? iconDisplayed : null);
          return Dismissible(
            background: stackBehindDismiss(),
            key: ObjectKey(words[index]),
            onDismissed: (direction) {
              var item = words.elementAt(index);
              //To delete
              deleteItem(index);
              visible.clear();
              visibleItems();
              //To show a snackbar when item is deleted
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Instance of word '$item' deleted"),
              ));
            },
            child: Container(
                child: ListTile(
              title: Text(
                word,
                textScaleFactor: 1.3,
              ),
              trailing: status,
              onTap: () {
                setState(() {
                  if (invisible.contains(words[index])) {
                    invisible.remove(word);
                  } else {
                    invisible.add(word);
                  }
                  visible.clear();
                  visibleItems();
                });
              },
            )),
          );
        });
  }

  void visibleItems() {
    setState(() {
      for (var i = 0; i < words.length; i++) {
        if (invisible.contains(words[i])) {
          continue;
        } else {
          visible.add(words[i]);
        }
      }
    });
  }

  void deleteItem(index) {
    setState(() {
      words.removeAt(index);
      writeState();
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

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void writeState() async {
    // getting shared preferences object
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // write
    prefs.setStringList("my_string_list_key", words);
  }

  Future loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> data = new List();
    data = prefs.getStringList("my_string_list_key");
    setState(() {
      words.addAll(data);
    });
  }
}
