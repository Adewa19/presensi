import 'package:presensi/main.dart';
import 'package:presensi/model/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Editabsen extends StatefulWidget {
  List list;
  int index;
  Editabsen({this.index, this.list});
  @override
  _EditabsenState createState() => _EditabsenState();
}

class _EditabsenState extends State<Editabsen> {
  final _key = new GlobalKey<FormState>();
  String jam;
  TextEditingController txtJam;

  setup() {
    txtJam = TextEditingController(text: '${widget.list[widget.index]['jam']}');
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      submit();
    } else {}
  }

  submit() async {
    String nik = '${widget.list[widget.index]['nik']}';
    String tgl = '${widget.list[widget.index]['tanggal']}';
    String id = '${widget.list[widget.index]['id']}';

    final response = await http.post(BaseUrl.updateabsen,
        body: {"nik": nik, "jam": jam, "tgl": tgl, "id": id});

    final data = jsonDecode(response.body);

    int value = data['value'];
    String pesan = data['message'];

    if (value == 1) {
      print(pesan);
      setState(() {
        _showDialogSuccess();
      });
    } else {
      print(pesan);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setup();
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
          content: new Text("Proses update berhasil"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
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
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                check();
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: new Text(
        'Edit Jam',
        style: TextStyle(fontSize: 16.0, color: Colors.white),
      )),
      body: Form(
        key: _key,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              controller: txtJam,
              onSaved: (e) => jam = e,
              decoration: InputDecoration(labelText: 'Jam'),
            ),
            new Padding(padding: EdgeInsets.only(bottom: 40.0)),
            new RaisedButton(
              child: new Text("Proses",
                  style:
                      TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
              color: Colors.red,
              onPressed: () {
                _alertDialog();
              },
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
          ],
        ),
      ),
    );
  }
}
