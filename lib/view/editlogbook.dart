import 'package:presensi/main.dart';
import 'package:presensi/model/api.dart';
import 'package:presensi/view/detaillogbook.dart';
import 'package:presensi/view/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditLogBook extends StatefulWidget {
  String id;
  String catatan;
  EditLogBook({this.id, this.catatan});
  @override
  _EditLogBookState createState() => _EditLogBookState();
}

class _EditLogBookState extends State<EditLogBook> {
  final _key = new GlobalKey<FormState>();
  TextEditingController catatan;
  String txtcatatan;
  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();

  setup() {
    catatan = TextEditingController(text: '${widget.catatan}');
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      submit();
    } else {}
  }

  submit() async {
    String id = '${widget.id}';

    final response = await http
        .post(BaseUrl.updatelogbook, body: {"id": id, "catatan": txtcatatan});

    final data = jsonDecode(response.body);

    int value = data['value'];
    String pesan = data['message'];

    if (value == 1) {
      _snackbar(pesan);
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Login()), (route) => true);
      });
    } else {
      _snackbar(pesan);
    }
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
  void initState() {
    // TODO: implement initState
    super.initState();
    setup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: new Text(
        'Edit LogBook',
        style: TextStyle(fontSize: 16.0, color: Colors.white),
      )),
      body: Form(
        key: _key,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              maxLines: 15,
              controller: catatan,
              onSaved: (e) => txtcatatan = e,
              decoration: InputDecoration(labelText: 'Catatan kegiatan'),
            ),
            new Padding(padding: EdgeInsets.only(bottom: 40.0)),
            new RaisedButton(
              child: new Text("Updated",
                  style:
                      TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
              color: Colors.lightBlue,
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
