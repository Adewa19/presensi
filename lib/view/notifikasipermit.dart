import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presensi/model/api.dart';
import 'package:http/http.dart' as http;
import 'package:presensi/view/detailnotifikasi.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:presensi/view/detailNotifikasi.dart';
// import 'package:presensi/view/inputNotifikasi.dart';

class NotifikasiPermit extends StatefulWidget {
  @override
  _NotifikasiPermitState createState() => _NotifikasiPermitState();
}

String useridUsers;

class _NotifikasiPermitState extends State<NotifikasiPermit> {
  static int page;
  ScrollController _sc = new ScrollController();
  bool isLoading = false;
  List users = new List();
  final dio = new Dio();

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    useridUsers = preferences.getString("id");
    page = 0;
    this._getMoreData(page, useridUsers);

    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent) {
        _getMoreData(page, useridUsers);
      }
    });

    searchController.addListener(() {
      if (this.mounted) {
        setState(() {
          filter = searchController.text;
        });
      }
    });
  }

  @override
  void initState() {
    if (this.mounted) {
      setState(() {
        super.initState();
        getPref();
      });
    }
  }

  @override
  void dispose() {
    if (this.mounted) {
      super.dispose();
      _sc.dispose();
      searchController.dispose();
    }
  }

  TextEditingController searchController = new TextEditingController();
  String filter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: const Text("Notifikasi anda !",
            style: TextStyle(fontSize: 16.0, color: Colors.white)),
      ),
      body: Stack(
        children: [
          Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ),
          Container(
            child: Column(
              children: [
                new Padding(
                  padding: new EdgeInsets.all(8.0),
                  child: new TextField(
                    style: TextStyle(fontSize: 13.0, color: Colors.white),
                    controller: searchController,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.white),
                      hintText: 'Pencarian berdasarkan nama ...',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                  ),
                ),
                new Expanded(
                  child: _buildList(),
                ),
              ],
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: users.length + 1, // Add one more item for progress indicator
      padding: EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (BuildContext context, int index) {
        if (index == users.length) {
          return _buildProgressIndicator();
        } else {
          return filter == null || filter == ""
              ? GestureDetector(
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new DetailNotifikasi(
                            list: users,
                            index: index,
                          ))),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new ListTile(
                        leading: CircleAvatar(
                            radius: 20.0,
                            backgroundImage: AssetImage('gambar/logo/jam.png')),
                        title: Text((users[index]['subject']),
                            style: TextStyle(color: Colors.black)),
                        subtitle: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    DateFormat(
                                      "dd-MM-yyyy",
                                    ).format(DateTime.parse(
                                        (users[index]['waktu']))),
                                    style: TextStyle(color: Colors.black)),
                                Text((users[index]['header']),
                                    style: TextStyle(color: Colors.black)),
                                // Icon(
                                //   Icons.arrow_right,
                                //   size: 30,
                                // )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 220,
                                  child: Text((users[index]['pesan']),
                                      style: TextStyle(color: Colors.black)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : users[index]['subject']
                      .toLowerCase()
                      .contains(filter.toLowerCase())
                  ? GestureDetector(
                      onTap: () => Navigator.of(context).push(
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new DetailNotifikasi(
                                    list: users,
                                    index: index,
                                  ))),
                      child: Card(
                        child: new ListTile(
                          leading: CircleAvatar(
                              radius: 20.0,
                              backgroundImage:
                                  AssetImage('gambar/logo/jam.png')),
                          title: Text((users[index]['subject']),
                              style: TextStyle(color: Colors.black)),
                          subtitle: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      DateFormat(
                                        "dd-MM-yyyy",
                                      ).format(DateTime.parse(
                                          (users[index]['waktu']))),
                                      style: TextStyle(color: Colors.black)),
                                  Text((users[index]['header']),
                                      style: TextStyle(color: Colors.black)),
                                  // Icon(
                                  //   Icons.arrow_right,
                                  //   size: 30,
                                  // )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 220,
                                    child: Text((users[index]['pesan']),
                                        style: TextStyle(color: Colors.black)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : new Container();
        }
      },
      controller: _sc,
    );
  }

  void _getMoreData(int index, String userid) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      var url = BaseUrl.loadNotifikasiPermit +
          "user_id=" +
          userid +
          "&limit=10&page=" +
          index.toString();

      final response = await dio.get(url);
      final data = jsonDecode(response.data);

      List tList = new List();

      for (int i = 0; i < data['results'].length; i++) {
        tList.add(data['results'][i]);
      }

      setState(() {
        isLoading = false;
        users.addAll(tList);
        page++;
      });
    }
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
}
