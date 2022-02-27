import 'package:presensi/model/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:presensi/view/karyawan.dart';
import 'package:presensi/view/lupapassword.dart';
import 'package:presensi/view/password.dart';
import 'package:presensi/view/upload.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String userid, username, namalengkap, jabatan, nik, foto, urlfoto;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (this.mounted) {
      setState(() {
        userid = preferences.getString("id");
        username = preferences.getString("username");
        namalengkap = preferences.getString("nama");
        jabatan = preferences.getString("jabatan");
        nik = preferences.getString("nik");
        foto = preferences.getString("foto");
        urlfoto = foto;
      });
    }
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
    if (this.mounted) {
      super.initState();
      getPref();
      getData();
    }
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
      // backgroundColor: Colors.blueGrey,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              children: [
                Container(
                  height: 150,
                  //SAMA HALNYA DENGAN CONTAINER SEBELUMNYA, WARNANYA DI-SET DAN BORDERRADIUSNYA KALI INI BERBEDA KITA SET KE-4 SISINYA AGAR MELENGKUNG
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: DefaultTextStyle(
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: new Stack(children: <Widget>[
                            Container(
                                width: 200.0,
                                height: 200.0,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                        fit: BoxFit.cover,
                                        image: new NetworkImage(urlfoto ??
                                            "https://kreditmandiri.co.id/api_test/absensi/profile/photo.jpg")))),
                            IconButton(
                              icon: Icon(
                                Icons.camera_alt,
                                color: Colors.lightBlue,
                              ),
                              onPressed: () => Navigator.of(context).push(
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          new UploadImage())),
                              padding: EdgeInsets.all(85.0),
                              splashColor: Colors.transparent,
                              highlightColor: Colors.lightBlue,
                              iconSize: 35.0,
                            ),
                          ]),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
          return Column(
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'NIK',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: 200.0,
                          child: Text(list[i]['nik'] ?? ''),
                        )
                      ],
                    ),
                    Divider(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Nama lengkap',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: 200.0,
                          child: Text(list[i]['nama'] ?? ''),
                        )
                      ],
                    ),
                    Divider(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Jabatan',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: 200.0,
                          child: Text(list[i]['nama_jabatan'] ?? ''),
                        )
                      ],
                    ),
                    Divider(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text('No Handphone',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          width: 200.0,
                          child: Text(list[i]['hp'] ?? ''),
                        )
                      ],
                    ),
                    Divider(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text('Alamat',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          width: 200.0,
                          child: Text(list[i]['alamat'] ?? ''),
                        )
                      ],
                    ),
                    Divider(
                      height: 30.0,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Container(
                    //       child: Text('Status',
                    //           style: TextStyle(fontWeight: FontWeight.bold)),
                    //     ),
                    //     Container(
                    //       width: 200.0,
                    //       child: Text(list[i]['status'] ?? ''),
                    //     )
                    //   ],
                    // ),
                    // Divider(
                    //   height: 30.0,
                    // ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
