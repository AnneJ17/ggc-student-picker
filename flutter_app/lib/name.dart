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

  bool _canSave = false;
  ModelData _data = ModelData.empty();

  void _setCanSave(bool save) {
    if (save != _canSave) setState(() => _canSave = save);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.clear),
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
