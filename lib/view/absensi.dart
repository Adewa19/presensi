import 'package:presensi/main.dart';
import 'package:presensi/view/inputabsen.dart';
import 'package:presensi/view/login.dart';
import 'package:flutter/material.dart';
import 'package:presensi/model/api.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:presensi/view/detailabsen.dart';
import 'package:url_launcher/url_launcher.dart';

class Absensi extends StatefulWidget {
  @override
  _AbsensiState createState() => _AbsensiState();
}

class _AbsensiState extends State<Absensi> {
  String nikUsers, jabatan;
  bool _isLoading = false;
  final snackbarKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();

  void _snackbar(String str) {
    if (str.isEmpty) return;
    _scaffoldState.currentState.showSnackBar(new SnackBar(
      backgroundColor: Colors.red,
      content: new Text(str,
          style: new TextStyle(fontSize: 15.0, color: Colors.white)),
      duration: new Duration(seconds: 5),
    ));
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (this.mounted) {
      setState(() {
        nikUsers = preferences.getString("nik");
        jabatan = preferences.getString("jabatan");
      });
    }
  }

  Future<List> getData() async {
    if (nikUsers == null) {
    } else {
      final response = await http.post(BaseUrl.absen, body: {"nik": nikUsers});
      return jsonDecode(response.body);
    }
  }

  callabsen() async {
    if (!_isLoading) {
      //SET VALUE LOADING JADI TRUE, DAN TEMPATKAN DI DALAM SETSTATE UNTUK MEMBERITAHUKAN PADA WIDGET BAHWA TERJADI PERUBAHAN STATE
      setState(() {
        _isLoading = true;
      });
      final response =
          await http.post(BaseUrl.callabsen, body: {"nik": nikUsers});
      final data = jsonDecode(response.body);
      int value = data['value'];
      String pesan = data['message'];

      if (value == 1) {
        setState(() {
          _showDialogSuccess();
        });
      } else {
        _snackbar(pesan);
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showDialogSuccess() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Success !!!",
            style: new TextStyle(color: Colors.lightBlue),
          ),
          content: new Text("Proses Call presensi berhasil"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                setState(() {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => Login()),
                      (route) => false);
                });
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _alertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi'),
          titleTextStyle: TextStyle(color: Colors.black),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Apakah anda yakin !!!.',
                  style: TextStyle(fontSize: 13.0),
                ),
                // Text('You\’re like me. I’m never satisfied.'),
              ],
            ),
          ),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                _isLoading
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : callabsen();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getData();
    getPref();
  }

  @override
  void dispose() {
    if (this.mounted) {
      // TODO: implement dispose
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: new Text(
          'List My Absen',
          style: TextStyle(fontSize: 16.0, color: Colors.white),
        ),
        actions: <Widget>[
          FlatButton(
            child: _isLoading
                ? CircularProgressIndicator(
                    //UBAH COLORNYA JADI PUTIH KARENA APPBAR KITA WARNA BIRU DAN DEFAULT LOADING JG BIRU
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
            onPressed: () => {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Inputabsen()))
            },
          ),
          FlatButton(
              onPressed: () async {
                var url = BaseUrl.downloadpdf + nikUsers;
                if (await canLaunch(url) != null) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: Icon(
                Icons.download_outlined,
                color: Colors.white,
              ))
        ],
      ),
      // backgroundColor: Colors.amber[700],
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              color: Colors.lightBlue,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: DefaultTextStyle(
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Tanggal",
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "In",
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Sts-In",
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Out",
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Sts-Out",
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Divider(color: Colors.black,),
            Expanded(
              child: Container(
                child: new FutureBuilder<List>(
                  future: getData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? new ItemList(
                            list: snapshot.data,
                          )
                        : new Center(
                            child: new CircularProgressIndicator(),
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        child: Icon(Icons.get_app),
        onPressed: () {
          _alertDialog();
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i) {
          return new GestureDetector(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: DefaultTextStyle(
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            list[i]['tgl'] ?? '',
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            list[i]['in'] ?? '',
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: (list[i]['sts_masuk'] == '0')
                                ? Icon(
                                    Icons.assignment_late_outlined,
                                    color: Colors.grey,
                                  )
                                : Icon(
                                    Icons.assignment_turned_in_outlined,
                                    color: Colors.green,
                                  )),
                        Expanded(
                          flex: 1,
                          child: Text(
                            list[i]['out'] ?? '',
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: (list[i]['sts_keluar'] == '0')
                                ? Icon(
                                    Icons.assignment_late_outlined,
                                    color: Colors.grey,
                                  )
                                : Icon(
                                    Icons.assignment_turned_in_outlined,
                                    color: Colors.green,
                                  )),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
