import 'package:flutter/material.dart';
import 'package:presensi/view/historylogbook.dart';
import 'package:presensi/view/logbook.dart';

class TabLogBook extends StatefulWidget {
  @override
  _TabLogBookState createState() => _TabLogBookState();
}

class _TabLogBookState extends State<TabLogBook> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: <Widget>[
            LogBook(),
            // Settings(),
            HistoryLogBook(),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.lightBlue,
          child: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.lightBlue[900],
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.book),
                child: new Text(
                  "LogBook",
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              Tab(
                icon: Icon(Icons.history),
                child: new Text(
                  "History",
                  style: TextStyle(fontSize: 12.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
