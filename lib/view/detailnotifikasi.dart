import 'dart:convert';
import 'package:presensi/view/Notifikasi.dart';
import 'package:flutter/material.dart';
import 'package:presensi/main.dart';
import 'package:presensi/model/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DetailNotifikasi extends StatefulWidget {
  List list;
  int index;
  DetailNotifikasi({this.index, this.list});
  @override
  _DetailNotifikasiState createState() => _DetailNotifikasiState();
}

String nikUsers;

class _DetailNotifikasiState extends State<DetailNotifikasi> {
  bool _isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (this.mounted) {
      setState(() {
        nikUsers = preferences.getString("nik");
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      super.initState();
      getPref();
    });
  }

  @override
  void dispose() {
    if (this.mounted) {
      super.dispose();
    }
  }

  void _snackbar(String str) {
    if (str.isEmpty) return;
    // ignore: deprecated_member_use
    _scaffoldState.currentState.showSnackBar(new SnackBar(
      backgroundColor: Colors.red,
      content: new Text(str,
          style: new TextStyle(fontSize: 15.0, color: Colors.white)),
      duration: new Duration(seconds: 5),
    ));
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
                    : approvalpermit();
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

  approvalpermit() async {
    final response = await http.post(BaseUrl.approvalNotifikasi,
        body: {"id": widget.list[widget.index]['id']});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    if (value == 1) {
      _snackbar(pesan);
      setState(() {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) => new Notifikasi()));
      });
    } else {
      _snackbar(pesan);
    }
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
                    : rejectpermit();
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

  rejectpermit() async {
    final response = await http.post(BaseUrl.rejectNotifikasi,
        body: {"id": widget.list[widget.index]['id']});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    if (value == 1) {
      _snackbar(pesan);
      setState(() {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) => new Notifikasi()));
      });
    } else {
      _snackbar(pesan);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: new Text(
          'Detail Kegiatan Kerja',
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
                    title: new Text('Waktu'),
                    subtitle:
                        new Text(widget.list[widget.index]['waktu'] ?? ''),
                  ),
                  Divider(),
                  ListTile(
                    title: new Text('Subject'),
                    subtitle:
                        new Text(widget.list[widget.index]['subject'] ?? ''),
                  ),
                  Divider(),
                  ListTile(
                    title: new Text('Title'),
                    subtitle:
                        new Text(widget.list[widget.index]['header'] ?? ''),
                  ),
                  Divider(),
                  ListTile(
                    title: new Text('Keterangan'),
                    subtitle:
                        new Text(widget.list[widget.index]['pesan'] ?? ''),
                  ),
                  Divider(),
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
    );
  }
}
