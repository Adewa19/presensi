import 'package:flutter/material.dart';
import 'package:presensi/view/historylembur1.dart';
import 'package:presensi/view/lembur1.dart';

class TabLembur extends StatefulWidget {
  @override
  _TabLemburState createState() => _TabLemburState();
}

class _TabLemburState extends State<TabLembur> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: <Widget>[
            Lembur(),
            // Settings(),
            HistoryLembur(),
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
                  "Lembur",
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
