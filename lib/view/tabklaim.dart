import 'package:flutter/material.dart';
import 'package:presensi/view/historyklaim1.dart';
import 'package:presensi/view/klaim.dart';

class TabKlaim extends StatefulWidget {
  @override
  _TabKlaimState createState() => _TabKlaimState();
}

class _TabKlaimState extends State<TabKlaim> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: <Widget>[
            Rawatjalan(),
            // Settings(),
            HistoryKlaim(),
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
                  "Claim",
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
