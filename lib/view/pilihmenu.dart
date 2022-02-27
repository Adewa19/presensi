import 'package:presensi/view/absensi.dart';
import 'package:presensi/view/absensilembur.dart';
import 'package:presensi/view/laporan.dart';
import 'package:presensi/view/notifikasi.dart';
import 'package:presensi/view/notifikasiabsen.dart';
import 'package:presensi/view/notifikasilembur.dart';
import 'package:presensi/view/notifikasipermit.dart';
import 'package:presensi/view/tablogbook.dart';
import 'package:flutter/material.dart';
import 'package:presensi/view/location.dart';
import 'package:presensi/view/password.dart';
import 'package:presensi/view/tabklaim.dart';
import 'package:presensi/view/tablembur.dart';
import 'package:presensi/view/tabpermit.dart';

class Pilihmenu extends StatefulWidget {
  String title;
  Pilihmenu({this.title});

  @override
  _PilihmenuState createState() => _PilihmenuState();
}

class _PilihmenuState extends State<Pilihmenu> {
  String menu;

  menubar() {
    menu = widget.title;
    if (menu == 'presensi') {
      return Absensi();
    } else if (menu == 'Lokasi') {
      return LocationArea();
    } else if (menu == 'Password') {
      return Password();
    } else if (menu == "RawatJalan") {
      return TabKlaim();
    } else if (menu == "permit") {
      return TabPermit();
    } else if (menu == "lembur") {
      return AbsensiLembur();
    } else if (menu == "logbook") {
      return TabLogBook();
    } else if (menu == "verifabsen") {
      return NotifikasiAbsen();
    } else if (menu == "veriflembur") {
      return NotifikasiLembur();
    } else if (menu == "verifijin") {
      return NotifikasiPermit();
    } else if (menu == "laporan") {
      return Laporan();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
      child: menubar(),
    ));
  }
}
