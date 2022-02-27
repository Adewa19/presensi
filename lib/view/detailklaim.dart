import 'dart:convert';

import 'package:presensi/view/login.dart';
import 'package:flutter/material.dart';
import 'package:presensi/main.dart';
import 'package:presensi/model/api.dart';
import 'package:presensi/view/editklaim.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class DetailKalim extends StatefulWidget {
  List list;
  int index;
  DetailKalim({this.index, this.list});
  @override
  _DetailKalimState createState() => _DetailKalimState();
}

int statushc;
String nikUsers;

class _DetailKalimState extends State<DetailKalim> {
  bool _isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();
  final formatter = new NumberFormat("#,###,###");

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nikUsers = preferences.getString("nik");
      print(nikUsers);
    });
  }

  Future<void> _alertDialogReject() async {
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
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                _isLoading
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : rejectklaim();
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

  Future<void> _alertDialogApprove() async {
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
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                _isLoading
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : approvalklaim();
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

  void _snackbar(String str) {
    if (str.isEmpty) return;
    _scaffoldState.currentState.showSnackBar(new SnackBar(
      backgroundColor: Colors.red,
      content: new Text(str,
          style: new TextStyle(fontSize: 15.0, color: Colors.white)),
      duration: new Duration(seconds: 5),
    ));
  }

  approvalklaim() async {
    final response = await http.post(BaseUrl.approvalklaim,
        body: {"id": widget.list[widget.index]['id']});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    if (value == 1) {
      _snackbar(pesan);
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Login()), (route) => false);
      });
    } else {
      _snackbar(pesan);
    }
  }

  rejectklaim() async {
    final response = await http.post(BaseUrl.rejectklaim,
        body: {"id": widget.list[widget.index]['id']});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    if (value == 1) {
      _snackbar(pesan);
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Login()), (route) => false);
      });
    } else {
      _snackbar(pesan);
    }
  }

  @override
  void initState() {
    if (this.mounted) {
      // TODO: implement initState
      super.initState();
      getPref();
    }
  }

  @override
  void dispose() {
    if (this.mounted) {
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    var status;
    if (widget.list[widget.index]['status'] == '0') {
      status = 'Waiting';
    } else if (widget.list[widget.index]['status'] == '1') {
      status = "Approve";
    } else {
      status = "Reject";
    }
    int nominal = int.parse(widget.list[widget.index]['nominal']);

    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: new Text(
          'Detail pengajuan klaim',
          style: TextStyle(fontSize: 16.0, color: Colors.white),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: [
            new Container(
              child: Column(
                children: [
                  ListTile(
                    title: new Text('NIK'),
                    subtitle: new Text(widget.list[widget.index]['nik'] ?? ''),
                  ),
                  Divider(),
                  ListTile(
                    title: new Text('Tanggal buat'),
                    subtitle:
                        new Text(widget.list[widget.index]['tgl_buat'] ?? ''),
                  ),
                  Divider(),
                  ListTile(
                    title: new Text('Tanggal pemeriksaan'),
                    subtitle:
                        new Text(widget.list[widget.index]['tanggal'] ?? ''),
                  ),
                  Divider(),
                  ListTile(
                    title: new Text('Tipe'),
                    subtitle: new Text(widget.list[widget.index]['tipe'] ?? ''),
                  ),
                  Divider(),
                  ListTile(
                    title: new Text('Hubungan'),
                    subtitle:
                        new Text(widget.list[widget.index]['hubungan'] ?? ''),
                  ),
                  Divider(),
                  ListTile(
                    title: new Text('Rumah sakit / Klinik'),
                    subtitle: new Text(
                        widget.list[widget.index]['rumah_sakit'] ?? ''),
                  ),
                  Divider(),
                  ListTile(
                    title: new Text('Nominal'),
                    subtitle: new Text(formatter.format(nominal)),
                  ),
                  Divider(),
                  ListTile(
                    title: new Text('Keterangan'),
                    subtitle:
                        new Text(widget.list[widget.index]['keterangan'] ?? ''),
                  ),
                  Divider(),
                  ListTile(
                    title: new Text('Status'),
                    subtitle: new Text(status ?? ''),
                  ),
                  Divider(),
                  ListTile(
                    title: new Text('File'),
                    subtitle: new Image.network(BaseUrl.urlfilekklaim +
                        widget.list[widget.index]['file']),
                  ),
                  Divider(),
                  if (nikUsers != widget.list[widget.index]['nik'] &&
                      widget.list[widget.index]['status'] == '0')
                    Center(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                _alertDialogApprove();
                              },
                              child: Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.lightBlue[900]),
                                child: Center(
                                  child: _isLoading
                                      ? CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.white),
                                        )
                                      : Text(
                                          "Approved",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                ),
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                              onTap: () {
                                _alertDialogReject();
                              },
                              child: Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.red[900]),
                                child: Center(
                                  child: _isLoading
                                      ? CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.white),
                                        )
                                      : Text(
                                          "Reject",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                ),
                              )),
                        ],
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () {
      //       Navigator.of(context).push(new MaterialPageRoute(
      //           builder: (BuildContext context) => new EditKlaim(
      //                 idklaim: widget.list[widget.index]['id'],
      //               )));
      //     },
      //     child: Icon(Icons.edit)),
    );
  }
}
