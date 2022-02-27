import 'package:intl/intl.dart';
import 'package:presensi/model/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class Karyawan extends StatefulWidget {
  @override
  _KaryawanState createState() => _KaryawanState();
}

String nik;

final GlobalKey<ScaffoldState> _scaffoldState = new GlobalKey<ScaffoldState>();

void _snackbar(String str) {
  if (str.isEmpty) return;
  _scaffoldState.currentState.showSnackBar(new SnackBar(
    backgroundColor: Colors.red,
    content: new Text(str,
        style: new TextStyle(fontSize: 15.0, color: Colors.white)),
    duration: new Duration(seconds: 5),
  ));
}

class _KaryawanState extends State<Karyawan> {
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nik = preferences.getString("nik");
    });
  }

  Future<List> getData() async {
    if (nik == null) {
    } else {
      final response = await http.post(BaseUrl.getprofile, body: {"nik": nik});
      return jsonDecode(response.body);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: new Text(
          'Data Pribadi',
          style: TextStyle(fontSize: 16.0, color: Colors.white),
        ),
      ),
      // backgroundColor: Colors.amber[700],
      body: Container(
        child: Card(
          // color: Colors.amber[700],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});
  bool _isLoading = false;
  final _key = new GlobalKey<FormState>();
  String nama,
      tempatlahir,
      hp,
      alamat,
      agama,
      kota,
      provinsi,
      negara,
      tgllahir,
      kelamin,
      noidentitas;

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      _isLoading = true;
      prosesupdate();
    }
  }

  prosesupdate() async {
    final response = await http.post(BaseUrl.updatedatapribadi, body: {
      "nik": nik,
      "nama": nama,
      "noidentitas": noidentitas,
      "tempatlahir": tempatlahir,
      "tgllahir": tgllahir,
      "hp": hp,
      "alamat": alamat,
      "agama": agama,
      "kota": kota,
      "provinsi": provinsi,
      "negara": negara,
      "kelamin": kelamin
    });
    final data = jsonDecode(response.body);
    var value = data['value'];

    if (value == 1) {
      _snackbar('Proses update berhasil');
    } else {
      _snackbar('Proses update gagal');
      _isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i) {
          var tgllahir = list[i]['tgl_lahir'];

          print(tgllahir);

          return Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              'No identitas',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.lightBlue[200]))),
                        child: TextFormField(
                          style: TextStyle(fontSize: 12.0),
                          validator: (e) {
                            if (e.isEmpty) {
                              return "Please masukan no identitas anda";
                            }
                          },
                          onSaved: (e) => noidentitas = e,
                          initialValue: list[i]['no_identitas'] ?? '',
                          decoration: InputDecoration(
                              hintText: "No identitas anda",
                              hintStyle: TextStyle(
                                  color: Colors.lightBlue, fontSize: 12.0)),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              'Nama lengkap',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.lightBlue[200]))),
                        child: TextFormField(
                          style: TextStyle(fontSize: 12.0),
                          validator: (e) {
                            if (e.isEmpty) {
                              return "Please masukan nama lengkap anda";
                            }
                          },
                          onSaved: (e) => nama = e,
                          initialValue: list[i]['nama'] ?? '',
                          decoration: InputDecoration(
                              hintText: "Nama lengkap",
                              hintStyle: TextStyle(
                                  color: Colors.lightBlue, fontSize: 12.0)),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              'Tempat lahir',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.lightBlue[200]))),
                        child: TextFormField(
                          style: TextStyle(fontSize: 12.0),
                          validator: (e) {
                            if (e.isEmpty) {
                              return "Please masukan tempat lahir anda";
                            }
                          },
                          onSaved: (e) => tempatlahir = e,
                          initialValue: list[i]['tmp_lahir'] ?? '',
                          decoration: InputDecoration(
                              hintText: "Tempat lahir anda",
                              hintStyle: TextStyle(
                                  color: Colors.lightBlue, fontSize: 12.0)),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              'Tanggal lahir',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.lightBlue[200]))),
                        child: TextFormField(
                          style: TextStyle(fontSize: 12.0),
                          validator: (e) {
                            if (e.isEmpty) {
                              return "Please masukan tanggal lahir anda";
                            }
                          },
                          onSaved: (e) => tgllahir = e,
                          initialValue: list[i]['tgl_lahir'] ?? '',
                          decoration: InputDecoration(
                              hintText: "yyyy-mm-dd",
                              hintStyle: TextStyle(
                                  color: Colors.lightBlue, fontSize: 12.0)),
                        ),
                        // child: DateTimePickerFormField(
                        //   style: TextStyle(fontSize: 13.0, color: Colors.black),
                        //   inputType: InputType.date,
                        //   format: DateFormat("yyyy-MM-dd"),
                        //   initialDate: tgllahir,
                        //   editable: false,
                        //   decoration: InputDecoration(
                        //     labelText: 'Tanggal',
                        //     labelStyle:
                        //         TextStyle(fontSize: 13.0, color: Colors.lightBlue),
                        //   ),
                        //   onChanged: (dt) {
                        //     tgllahir = dt;
                        //   },
                        // ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              'Jenis kelamin  (Pria / Wanita)',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.lightBlue[200]))),
                        child: TextFormField(
                          style: TextStyle(fontSize: 12.0),
                          validator: (e) {
                            if (e.isEmpty) {
                              return "Please masukan jenis kelamin anda";
                            }
                          },
                          onSaved: (e) => kelamin = e,
                          initialValue: list[i]['kelamin'] ?? '',
                          decoration: InputDecoration(
                              hintText: "Jenis kelamin anda",
                              hintStyle: TextStyle(
                                  color: Colors.lightBlue, fontSize: 12.0)),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              'No Handphone',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.lightBlue[200]))),
                        child: TextFormField(
                          style: TextStyle(fontSize: 12.0),
                          validator: (e) {
                            if (e.isEmpty) {
                              return "Please masukan tno handphone anda";
                            }
                          },
                          onSaved: (e) => hp = e,
                          initialValue: list[i]['hp'] ?? '',
                          decoration: InputDecoration(
                              hintText: "No Handphone anda",
                              hintStyle: TextStyle(
                                  color: Colors.lightBlue, fontSize: 12.0)),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              'Alamamt sekarang',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.lightBlue[200]))),
                        child: TextFormField(
                          style: TextStyle(fontSize: 12.0),
                          validator: (e) {
                            if (e.isEmpty) {
                              return "Please masukan alamat sekarang anda";
                            }
                          },
                          onSaved: (e) => alamat = e,
                          initialValue: list[i]['alamat'] ?? '',
                          decoration: InputDecoration(
                              hintText: "Alamat sekarang anda",
                              hintStyle: TextStyle(
                                  color: Colors.lightBlue, fontSize: 12.0)),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              'Agama',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.lightBlue[200]))),
                        child: TextFormField(
                          style: TextStyle(fontSize: 12.0),
                          validator: (e) {
                            if (e.isEmpty) {
                              return "Please masukan agama anda";
                            }
                          },
                          onSaved: (e) => agama = e,
                          initialValue: list[i]['agama'] ?? '',
                          decoration: InputDecoration(
                              hintText: "Agama anda",
                              hintStyle: TextStyle(
                                  color: Colors.lightBlue, fontSize: 12.0)),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              'Negara',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.lightBlue[200]))),
                        child: TextFormField(
                          style: TextStyle(fontSize: 12.0),
                          validator: (e) {
                            if (e.isEmpty) {
                              return "Please masukan negara anda";
                            }
                          },
                          onSaved: (e) => negara = e,
                          initialValue: list[i]['negara'] ?? '',
                          decoration: InputDecoration(
                              hintText: "Negara anda",
                              hintStyle: TextStyle(
                                  color: Colors.lightBlue, fontSize: 12.0)),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              'Provinsi',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.lightBlue[200]))),
                        child: TextFormField(
                          style: TextStyle(fontSize: 12.0),
                          validator: (e) {
                            if (e.isEmpty) {
                              return "Please masukan provinsi anda";
                            }
                          },
                          onSaved: (e) => provinsi = e,
                          initialValue: list[i]['propinsi'] ?? '',
                          decoration: InputDecoration(
                              hintText: "Provinsi anda",
                              hintStyle: TextStyle(
                                  color: Colors.lightBlue, fontSize: 12.0)),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              'Kota',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.lightBlue[200]))),
                        child: TextFormField(
                          style: TextStyle(fontSize: 12.0),
                          validator: (e) {
                            if (e.isEmpty) {
                              return "Please masukan kota anda";
                            }
                          },
                          onSaved: (e) => kota = e,
                          initialValue: list[i]['kota'] ?? '',
                          decoration: InputDecoration(
                              hintText: "Kota anda",
                              hintStyle: TextStyle(
                                  color: Colors.lightBlue, fontSize: 12.0)),
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      GestureDetector(
                          onTap: () {
                            check();
                          },
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.lightBlue[900]),
                            child: Center(
                              child: _isLoading
                                  ? CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    )
                                  : Text(
                                      "Update",
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
          );
        },
      ),
    );
  }
}
