import 'dart:convert';
import 'package:presensi/view/mainmenu.dart';
import 'package:http/http.dart' as http;
import 'package:presensi/model/api.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginState extends State<Login> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  String username, password;
  final _key = new GlobalKey<FormState>();
  String msg = "";
  bool _secureText = true;
  bool _apiCall = false;

  showHide() {
    if (this.mounted) {
      setState(() {
        _secureText = !_secureText;
      });
    }
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      if (this.mounted) {
        setState(() {
          _apiCall = true;
        });
      }
      login();
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();

  void _snackbar(String str) {
    if (str.isEmpty) return;
    _scaffoldState.currentState.showSnackBar(new SnackBar(
      backgroundColor: Colors.red,
      content: new Text(str,
          style: new TextStyle(fontSize: 15.0, color: Colors.white)),
      duration: new Duration(seconds: 5),
    ));
  }

  login() async {
    print(BaseUrl.login);
    print(username);
    print("masuk");
    // print(password);
    final response = await http.post(BaseUrl.login,
        body: {"username": username, "password": password});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    String usernameAPI = data['user'];
    String namaAPI = data['nama'];
    String id = data['user_id'];
    String jabatan = data['jabatan'];
    String nik = data['nik'];
    String foto = data['foto'];

    if (value == 1) {
      if (this.mounted) {
        setState(() {
          _loginStatus = LoginStatus.signIn;
          savePref(value, usernameAPI, namaAPI, id, jabatan, foto, nik);
          getFCMToken(nik);
        });
      }
      _snackbar(pesan);
    } else {
      _snackbar(pesan);
      if (this.mounted) {
        setState(() {
          _apiCall = false;
        });
      }
    }
  }

  savePref(int value, String username, String nama, String id, String jabatan,
      String foto, String nik) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (this.mounted) {
      setState(() {
        preferences.setInt("value", value);
        preferences.setString("nama", nama);
        preferences.setString("username", username);
        preferences.setString("id", id);
        preferences.setString("jabatan", jabatan);
        preferences.setString("nik", nik);
        preferences.setString("foto", foto);
        preferences.commit();
      });
    }
  }

  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (this.mounted) {
      setState(() {
        value = preferences.getInt("value");
        _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
      });
    }
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (this.mounted) {
      setState(() {
        _apiCall = false;
        preferences.setInt("value", null);
        preferences.commit();
        _loginStatus = LoginStatus.notSignIn;
      });
    }
  }

  void getFCMToken(nik) async {
    var deviceState = await OneSignal.shared.getDeviceState();
    String fcmtoken = deviceState.userId;
    final response = await http
        .post(BaseUrl.updatefcmtoken, body: {"fcmtoken": fcmtoken, "nik": nik});
    final data = jsonDecode(response.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    if (this.mounted) {
      super.initState();
      getPref();
      OneSignal.shared
          .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
        print("notifikasion di tap");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
          // appBar: AppBar(title: new Text("Login"),),
          key: _scaffoldState,
          body: Form(
            key: _key,
            child: new Container(
              padding: EdgeInsets.only(top: 50.0),
              decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                Colors.lightBlue[900],
                Colors.lightBlue[700],
                Colors.lightBlue[500]
              ])),
              child: new Center(
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 40),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "My Absen",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    Text(
                                      'PT. ALFA REKA USAHA',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: new Image.asset(
                                      "gambar/logo/logo.png",
                                      width: 150,
                                      height: 100,
                                    ),
                                  )
                                ],
                              ))
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              bottomRight: Radius.circular(50))),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(225, 95, 27, 3),
                                        blurRadius: 5,
                                        offset: Offset(0, 2))
                                  ]),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.lightBlue[200]))),
                                    child: TextFormField(
                                      validator: (e) {
                                        if (e.isEmpty) {
                                          return "Please insert NIK";
                                        }
                                      },
                                      onSaved: (e) => username = e,
                                      decoration: InputDecoration(
                                          hintText: "NIK",
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12.0)),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.lightBlue[200]))),
                                    child: TextFormField(
                                      obscureText: _secureText,
                                      validator: (e) {
                                        if (e.isEmpty) {
                                          return "Please insert password";
                                        }
                                      },
                                      onSaved: (e) => password = e,
                                      decoration: InputDecoration(
                                        hintText: "Password",
                                        hintStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.0),
                                        suffixIcon: IconButton(
                                          onPressed: showHide,
                                          icon: Icon(_secureText
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
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
                                    child: _apiCall
                                        ? CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white),
                                          )
                                        : Text(
                                            "Login",
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
                    )
                  ],
                ),
              ),
            ),
          ),
        );
        break;
      case LoginStatus.signIn:
        return MainMenu(signOut);
        break;
    }
  }
}