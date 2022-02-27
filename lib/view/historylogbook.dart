import 'dart:convert';

import 'package:presensi/view/detailLogBook.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presensi/model/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryLogBook extends StatefulWidget {
  @override
  _HistoryLogBookState createState() => _HistoryLogBookState();
}

String nikUsers;

class _HistoryLogBookState extends State<HistoryLogBook> {
  static int page;
  ScrollController _sc = new ScrollController();
  bool isLoading = false;
  List users = new List();
  final dio = new Dio();

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    nikUsers = preferences.getString("nik");
    page = 0;
    this._getMoreData(page, nikUsers);

    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent) {
        _getMoreData(page, nikUsers);
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
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: const Text("HistoryLogBook",
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
                      builder: (BuildContext context) => new DetailLogBook(
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
                        title: Text((users[index]['nama']),
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
                                        (users[index]['tanggal']))),
                                    style: TextStyle(color: Colors.black)),
                                Text((users[index]['jam_mulai']) ?? '',
                                    style: TextStyle(color: Colors.black)),
                                Text((users[index]['jam_selesai']) ?? '',
                                    style: TextStyle(color: Colors.black)),
                                Icon(
                                  Icons.arrow_right,
                                  size: 30,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : users[index]['nama']
                      .toLowerCase()
                      .contains(filter.toLowerCase())
                  ? GestureDetector(
                      onTap: () => Navigator.of(context).push(
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new DetailLogBook(
                                    list: users,
                                    index: index,
                                  ))),
                      child: Card(
                        child: new ListTile(
                          leading: CircleAvatar(
                              radius: 20.0,
                              backgroundImage:
                                  AssetImage('gambar/logo/jam.png')),
                          title: Text((users[index]['nama']) ?? '',
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
                                          (users[index]['tanggal']))),
                                      style: TextStyle(color: Colors.black)),
                                  Text(
                                      (users[index]['jam_mulai']) ??
                                          '' +
                                              ' - ' +
                                              (users[index]['jam_selesai']) ??
                                          '',
                                      style: TextStyle(color: Colors.black)),
                                  Text((users[index]['jam_selesai']) ?? '',
                                      style: TextStyle(color: Colors.black)),
                                  Icon(
                                    Icons.arrow_right,
                                    size: 30,
                                  )
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

  void _getMoreData(int index, String nik) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      var url = BaseUrl.loadHistoryLogBook +
          "nik=" +
          nik +
          "&limit=10&page=" +
          index.toString();

      final response = await dio.get(url);
      final data = jsonDecode(response.data);

      print(data);
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
