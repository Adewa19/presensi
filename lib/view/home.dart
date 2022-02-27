import 'package:presensi/model/api.dart';
import 'package:presensi/view/hyperlink.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:presensi/view/pilihmenu.dart';
import 'package:presensi/view/profile.dart';
import 'package:flutter/material.dart';
import 'package:presensi/view/setlokasi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

String userid, username, namalengkap = "", jabatan, nik, foto, urlfoto;

class _HomeState extends State<Home> {
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  static final List<String> imgSlider = [
    '1.jpg',
    '2.jpg',
    '3.jpg',
    '4.jpg',
  ];
  final CarouselSlider autoPlayImage = CarouselSlider(
    options: CarouselOptions(
      autoPlay: true,
      aspectRatio: 2.0,
      enlargeCenterPage: true,
    ),
    items: imgSlider.map((fileImage) {
      return Container(
        margin: EdgeInsets.all(2.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Image.network(
            BaseUrl.slider + '/${fileImage}',
            fit: BoxFit.fill,
          ),
        ),
      );
    }).toList(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueGrey,
      body: Stack(
        children: [
          Container(
            height: 200,
            //SAMA HALNYA DENGAN CONTAINER SEBELUMNYA, WARNANYA DI-SET DAN BORDERRADIUSNYA KALI INI BERBEDA KITA SET KE-4 SISINYA AGAR MELENGKUNG
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ),
          ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat datang !  ' + namalengkap ?? '',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'PT. ALFA REKA USAHA',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2,
              ),
              autoPlayImage,
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  color: Colors.lightBlue,
                  child: Center(
                    child: Text(
                      '== MENU APLIKASI ==',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              MenuUtama(),
            ],
          ),
        ],
      ),
    );
  }
}

class MenuUtama extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: (jabatan == 'MANAGER')
          ? Container(
              padding: EdgeInsets.all(8.0),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                children: <Widget>[
                  Card(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new Pilihmenu(
                                  title: "verifabsen",
                                )));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colors.lightBlue[900],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'gambar/logo/centang.png',
                                width: 40,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Text(
                              'Verifikasi Absen',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.0),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new Pilihmenu(
                                  title: "veriflembur",
                                )));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colors.lightBlue[900],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'gambar/logo/centang.png',
                                width: 40,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Text(
                              'Verifikasi Lembur',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.0),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new Pilihmenu(
                                  title: "verifijin",
                                )));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colors.lightBlue[900],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'gambar/logo/centang.png',
                                width: 40,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Text(
                              'Verifikasi Pengajuan',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.0),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  // Card(
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       Navigator.of(context).push(new MaterialPageRoute(
                  //           builder: (BuildContext context) => new Pilihmenu(
                  //                 title: "laporan",
                  //               )));
                  //     },
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Material(
                  //           borderRadius: BorderRadius.circular(100.0),
                  //           color: Colors.lightBlue[900],
                  //           child: Padding(
                  //             padding: const EdgeInsets.all(8.0),
                  //             child: Image.asset(
                  //               'gambar/logo/permit.png',
                  //               width: 40,
                  //             ),
                  //           ),
                  //         ),
                  //         SizedBox(
                  //           height: 8.0,
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.all(1.0),
                  //           child: Text(
                  //             'Laporan Absensi',
                  //             style: TextStyle(
                  //                 color: Colors.black,
                  //                 fontWeight: FontWeight.bold,
                  //                 fontSize: 10.0),
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            )
          : Container(
              padding: EdgeInsets.all(8.0),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                children: <Widget>[
                  Card(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new Pilihmenu(
                                  title: "presensi",
                                )));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colors.lightBlue[900],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'gambar/icon/Presensi.png',
                                width: 40,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Text(
                              'Absen',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.0),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new Pilihmenu(
                                  title: "permit",
                                )));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colors.lightBlue[900],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'gambar/icon/Perijinan.png',
                                width: 40,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Text(
                              'Pengajuan absen',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.0),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new Pilihmenu(
                                  title: "Lokasi",
                                )));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colors.lightBlue[900],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'gambar/icon/lokasi.png',
                                width: 40,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Text(
                              'Lokasi',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.0),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new Pilihmenu(
                                  title: "lembur",
                                )));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colors.lightBlue[900],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'gambar/icon/Lembur.png',
                                width: 40,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Text(
                              'Absen Lembur',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.0),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new Pilihmenu(
                                  title: "logbook",
                                )));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colors.lightBlue[900],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'gambar/icon/Logbook.png',
                                width: 40,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Text(
                              'logbook',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.0),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
