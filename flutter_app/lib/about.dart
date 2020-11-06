import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text('GGC Thorns, Roses and Buds'),
      ),
      body: Column(
        children: <Widget>[
          Image.asset('assets/bbuildingwavy.jpg'),
          Center(
              child: Container(
                  //padding via container widget
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Text('Created By General Grizzly',
                      style: TextStyle(fontSize: 27)))),
          Padding(
              //Padding Via Padding Widget
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Text('Created for ITEC 4550',
                  style: TextStyle(fontSize: 17))),
          Image.asset(
            'assets/grizzly.png',
            scale: 1.9,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Text('11/1/2020'),
          )
        ],
      ),
    );
  }
}
