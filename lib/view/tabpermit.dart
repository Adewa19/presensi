import 'package:flutter/material.dart';
import 'package:presensi/view/historypermit1.dart';
import 'package:presensi/view/permit1.dart';

class TabPermit extends StatefulWidget {
  @override
  _TabPermitState createState() => _TabPermitState();
}

class _TabPermitState extends State<TabPermit> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: <Widget>[
            Permit(),
            // Settings(),
            HistoryPermit(),
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
                  "Permit",
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
