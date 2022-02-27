import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:presensi/model/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;

class UploadImage extends StatefulWidget {
  @override
  UploadImageState createState() => UploadImageState();
}

class UploadImageState extends State<UploadImage> {
  //
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Image Empty !!!';
  String nik;
  final snackbarKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();

  bool _isLoading = false;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nik = preferences.getString("nik");
    });
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

    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse(BaseUrl.uploadfotoprofile);
    var request = new http.MultipartRequest("POST", uri);

    var multipartFile = new http.MultipartFile("gambar", stream, length,
        filename: path.basename(imageFile.path));
    request.fields['nik'] = nik;
    request.files.add(multipartFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });
      _snackbar("Uploaded Sukses");
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
          title: new Text(
        'Ganti Foto',
        style: TextStyle(fontSize: 16.0, color: Colors.white),
      )),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: ListView(
          children: <Widget>[
            OutlineButton(
              onPressed: () => _alertDialog(),
              child: Text(
                'Choose Image',
                style: TextStyle(color: Colors.black45),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            showImage(),
            SizedBox(
              height: 20.0,
            ),
            OutlineButton(
              child: _isLoading
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black45),
                    )
                  : Icon(
                      Icons.file_upload,
                      color: Colors.black45,
                    ),
              onPressed: () => startUpload(),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              status,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
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
    );
  }
}
