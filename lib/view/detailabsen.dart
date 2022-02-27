import 'package:presensi/model/api.dart';
import 'package:presensi/view/editabsen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Detailabsen extends StatefulWidget {
  List list;
  int index;
  Detailabsen({this.index, this.list});
  @override
  _DetailabsenState createState() => _DetailabsenState();
}

class _DetailabsenState extends State<Detailabsen> {
  Future<List> getData() async {
    String nik = '${widget.list[widget.index]['nik']}';
    String tgl = '${widget.list[widget.index]['tgl']}';

    final response =
        await http.post(BaseUrl.detailabsen, body: {"nik": nik, "tgl": tgl});
    return jsonDecode(response.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red[900],
      appBar: AppBar(
          title: new Text(
        'Detail absen ${widget.list[widget.index]['tgl']} ',
        style: TextStyle(fontSize: 16.0, color: Colors.white),
      )),
      body: new FutureBuilder<List>(
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => Navigator.of(context).push(MaterialPageRoute(
      //       builder: (context) => Requestpresensi(
      //             tanggal: widget.list[widget.index]['tgl'],
      //           ))),
      //   backgroundColor: Colors.lightBlue,
      //   child: Icon(Icons.edit),
      // ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        if (list[i]['unit'] == 'IT') {
          return new GestureDetector(
            child: Container(
              child: Card(
                child: new ListTile(
                  leading: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                              fit: BoxFit.cover,
                              image: new NetworkImage(list[i]['gambar'])))),
                  title: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [Text('Jam'), Text('Absen')],
                          ),
                          Column(
                            children: [
                              Text(
                                list[i]['jam'] ?? '',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                list[i]['keterangan'] ?? '',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          new IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Editabsen(
                                        list: list,
                                        index: i,
                                      )));
                            },
                            icon: Icon(Icons.edit),
                            tooltip: 'Edit waktu',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return new Container(
            child: Card(
              child: new ListTile(
                leading: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: new NetworkImage(list[i]['gambar'])))),
                title: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [Text('Jam'), Text('Absen')],
                        ),
                        Column(
                          children: [
                            Text(
                              list[i]['jam'] ?? '',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              list[i]['keterangan'] ?? '',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
