import 'package:flutter/material.dart';

class SendReceivePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('GGC Thorns, Roses and Buds'),
          bottom: getTabBar(),
        ),
        body: getTabBarPages(),
      ),
    );
  }

  Widget getTabBar() {
    return TabBar(tabs: [
      Tab(text: "Send", icon: Icon(Icons.arrow_upward)),
      Tab(text: "Receive", icon: Icon(Icons.arrow_downward)),
    ]);
  }

  Widget getTabBarPages() {
    return TabBarView(children: <Widget>[
      Container(
        child: Center(
          child: Text(
            "Send, Coming Soon!",
            textAlign: TextAlign.center,
          ),
        ),
      ),
      Container(
          child: Center(
        child: Text(
          "Receive - Coming Soon!",
          textAlign: TextAlign.center,
        ),
      )),
    ]);
  }
}
