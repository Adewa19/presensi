import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueGrey,
      body: Stack(
        children: [
          Container(
            height: 250,
            //SAMA HALNYA DENGAN CONTAINER SEBELUMNYA, WARNANYA DI-SET DAN BORDERRADIUSNYA KALI INI BERBEDA KITA SET KE-4 SISINYA AGAR MELENGKUNG
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
          new Center(
            child: ListView(
              children: <Widget>[
                new SizedBox(
                  height: 150.0,
                ),
                new Container(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Image.asset(
                        "gambar/logo/logo.png",
                        width: 150,
                        height: 100,
                      ),
                      new Padding(padding: EdgeInsets.only(bottom: 5.0)),
                      new Text(
                        "My Absen",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      new Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                      new Text(
                        " versi 2.0",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      new Text(
                        "PT. ALFA REKA USAHA",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      new Text(
                        "CopyRight@2021",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
