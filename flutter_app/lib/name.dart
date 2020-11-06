import 'package:flutter/material.dart';

class AddNamePage extends StatelessWidget {
  static String value = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.clear),
          title: Text('Add Student Name'),
          actions: <Widget>[
            FlatButton(
                textColor: Colors.white, onPressed: () {}, child: Text("ADD"))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: TextField(
            decoration: InputDecoration(hintText: 'Enter Name'),
            autofocus: true,
            onChanged: (text) {
              value = text;
            },
          ),
        ));
  }
}
