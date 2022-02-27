import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:presensi/model/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class EditKlaim extends StatefulWidget {
  String idklaim;
  EditKlaim({this.idklaim});
  @override
  _EditKlaimState createState() => _EditKlaimState();
}

String tanggaledit;
String tipeedit;
String hubunganedit;
String nominaledit;
String klinikedit;
String pesanedit;
String fileedit;

class _EditKlaimState extends State<EditKlaim> {
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Image Empty !!!';
  String nik;
  final snackbarKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();

  final _key = new GlobalKey<FormState>();

  bool _isLoading = false;
  String pesan;
  String idklaim;
  String klinik;
  String nominal;
  DateTime tanggal;
  String tipe;
  String hubungan;
  TextEditingController txttipe = TextEditingController(text: tipeedit);
  TextEditingController txttanggal = TextEditingController(text: tanggaledit);
  TextEditingController txtklinik = TextEditingController(text: klinikedit);
  TextEditingController txtpesan = TextEditingController(text: pesanedit);
  TextEditingController txtnominal = TextEditingController(text: nominaledit);

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nik = preferences.getString("nik");
      idklaim = widget.idklaim;
      getData();
    });
  }

  getData() async {
    print(idklaim);
    final response = await http.post(BaseUrl.editklaim, body: {"id": idklaim});
    final data = jsonDecode(response.body);

    // print(data);

    tanggaledit = data['tanggal'];
    tipeedit = data['tipe'];
    hubunganedit = data['hubungan'];
    nominaledit = data['nominal'];
    klinikedit = data['rumah_sakit'];
    pesanedit = data['keterangan'];
    fileedit = data['file'];
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

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.camera);
    });
    setStatus('');
  }

  chooseImage1() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      startUpload();
    } else {}
  }

  startUpload() {
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    upload(tmpFile);
  }

  Future upload(File imageFile) async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
    }

    if (klinik == null) {
      setState(() {
        _isLoading = false;
      });
      _snackbar("Rumah sakit / Klinik wajib disi");
    } else if (tanggal == null) {
      setState(() {
        _isLoading = false;
      });
      _snackbar("Tanggal wajib disi");
    } else if (nominal == null) {
      setState(() {
        _isLoading = false;
      });
      _snackbar("Nominal wajib disi");
    } else if (tipe == null) {
      setState(() {
        _isLoading = false;
      });
      _snackbar("Tipe wajib disi");
    } else if (hubungan == null) {
      setState(() {
        _isLoading = false;
      });
      _snackbar("Hubungan wajib disii");
    } else {
      var stream =
          new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();
      var uri = Uri.parse(BaseUrl.uploadrawatjalan);
      var request = new http.MultipartRequest("POST", uri);

      var multipartFile = new http.MultipartFile("gambar", stream, length,
          filename: path.basename(imageFile.path));
      request.fields['nik'] = nik;
      request.fields['rumahsakit'] = klinik;
      request.fields['tanggal'] = tanggal.toString();
      request.fields['tipe'] = tipe;
      request.fields['hubungan'] = hubungan;
      request.fields['pesan'] = pesan;
      request.fields['nominal'] = nominal;
      request.files.add(multipartFile);

      var response = await request.send();

      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false;
        });
        _snackbar("Uploaded Sukses");
        setState(() {
          Navigator.pop(context);
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        _snackbar("Upload Failed");
      }
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
    }
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Center(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
              width: 250,
              height: 250,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          );
        }
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
          actions: <Widget>[
            FlatButton(
              child: Text('Camera'),
              onPressed: () {
                chooseImage();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Galery'),
              onPressed: () {
                chooseImage1();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text(
          'Ubah Claim',
          style: TextStyle(fontSize: 16.0, color: Colors.white),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _key,
          child: ListView(
            children: <Widget>[
              DateTimePickerFormField(
                style: TextStyle(fontSize: 13.0, color: Colors.black),
                inputType: InputType.date,
                format: DateFormat("yyyy-MM-dd"),
                initialDate: DateTime.now(),
                editable: false,
                decoration: InputDecoration(
                  labelText: 'Tgl Pemeriksaan',
                  labelStyle:
                      TextStyle(fontSize: 13.0, color: Colors.lightBlue),
                ),
                onChanged: (dt) {
                  setState(() => tanggal = dt);
                  print(tanggal);
                },
              ),
              TextFormField(
                controller: txtklinik,
                onSaved: (e) => klinik = e,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: 'Rumah sakit / Klinik'),
              ),
              DropdownButton<String>(
                items: [
                  DropdownMenuItem<String>(
                    child: Text('Rawat Jalan'),
                    value: 'Rawat Jalan',
                  ),
                  DropdownMenuItem<String>(
                    child: Text('Rawat Inap'),
                    value: 'Rawat Inap',
                  ),
                  DropdownMenuItem<String>(
                    child: Text('Melahirkan'),
                    value: 'Melahirkan',
                  ),
                  DropdownMenuItem<String>(
                    child: Text('Gigi'),
                    value: 'Gigi',
                  ),
                ],
                onChanged: (String value) {
                  setState(() {
                    tipe = value;
                    print(tipe);
                  });
                },
                hint: Text('Pilih Tipe'),
                value: tipe,
              ),
              DropdownButton<String>(
                items: [
                  DropdownMenuItem<String>(
                    child: Text('Sendiri'),
                    value: 'Sendiri',
                  ),
                  DropdownMenuItem<String>(
                    child: Text('Suami / Istri'),
                    value: 'Suami / Istri',
                  ),
                  DropdownMenuItem<String>(
                    child: Text('Anak'),
                    value: 'Anak',
                  ),
                ],
                onChanged: (String value) {
                  setState(() {
                    hubungan = value;
                    print(hubungan);
                  });
                },
                hint: Text('Pilih Hubungan'),
                value: hubungan,
              ),
              TextFormField(
                controller: txtnominal,
                onSaved: (e) => nominal = e,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Masukan nominal'),
              ),
              TextFormField(
                controller: txtpesan,
                onSaved: (e) => pesan = e,
                decoration: InputDecoration(labelText: 'keterangan'),
              ),
              OutlineButton(
                onPressed: () => _alertDialog(),
                child: Text(
                  'Choose Image',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              showImage(),
              SizedBox(
                height: 20.0,
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
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : Text(
                              "Proses",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  )),
              SizedBox(
                height: 20.0,
              ),
              Text(
                status,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
