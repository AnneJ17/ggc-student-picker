import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data.dart';

class AddNamePage extends StatefulWidget {
  AddNamePage({Key key}) : super(key: key);
  @override
  _AddNamePageState createState() => _AddNamePageState();
}

class _AddNamePageState extends State<AddNamePage> {
  // this allows us to access the TextField text
  TextEditingController textFieldController = TextEditingController();
  ModelData _data = ModelData.empty();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  textFieldController.clear();
                },
              );
            },
          ),
          title: Text('Add Student Name'),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              child: Text("ADD"),
              onPressed: () {
                _sendDataBack(context);
              },
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: TextField(
            controller: textFieldController,
            decoration: InputDecoration(hintText: 'Enter Name'),
            autofocus: true,
            onChanged: (text) {
              _data.name = text;
            },
          ),
        ));
  }

  // get the text in the TextField and send it back to the FirstScreen
  void _sendDataBack(BuildContext context) {
    String textToSendBack = textFieldController.text;
    Navigator.pop(context, textToSendBack);
  }
}
