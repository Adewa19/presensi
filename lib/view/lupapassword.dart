import 'package:flutter/material.dart';

class LupaPassword extends StatefulWidget {
  @override
  _LupaPasswordState createState() => _LupaPasswordState();
}

class _LupaPasswordState extends State<LupaPassword> {
  String email;
  final _key = new GlobalKey<FormState>();
  bool _apiCall = false;

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _apiCall = true;
      });
      resetpassword();
    }
  }

  resetpassword() {
    print('masuk');
  }

  Widget progressWidget() {
    if (_apiCall)
      return Center(
        child: Column(
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.all(8.0),
            ),
            CircularProgressIndicator(),
            Text("Please wait")
          ],
        ),
      );
    else
      // jika sudah selesai kirim API
      return Center(
        child:
            Text('', style: new TextStyle(fontSize: 15.0, color: Colors.red)),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text(
          'Lupa Password',
          style: TextStyle(fontSize: 16.0, color: Colors.white),
        ),
      ),
      body: Form(
        key: _key,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.lightBlue[200]))),
              child: TextFormField(
                validator: (e) {
                  if (e.isEmpty) {
                    return "Please insert email your";
                  }
                },
                onSaved: (e) => email = e,
                decoration: InputDecoration(
                    hintText: "Email you",
                    hintStyle: TextStyle(color: Colors.lightBlue)),
              ),
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
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
            progressWidget(),
          ],
        ),
      ),
    );
  }
}
