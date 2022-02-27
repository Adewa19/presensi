import 'package:presensi/view/login.dart';
import 'package:flutter/material.dart';
import 'package:presensi/constant/constant.dart';
import 'package:presensi/launcher.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // OneSignal.shared
  //     .init("bb1a00d0-7d38-40ea-9fd7-2e2c8a58e5d6", iOSSettings: null);
  // OneSignal.shared
  //     .setInFocusDisplayType(OSNotificationDisplayType.notification);

  OneSignal.shared.setAppId("bb1a00d0-7d38-40ea-9fd7-2e2c8a58e5d6");

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "My Absen",
    home: Launcher(),
    theme: ThemeData(primaryColor: Colors.lightBlue[500]),
    routes: <String, WidgetBuilder>{
      SPLASH_SCREEN: (BuildContext context) => Launcher(),
      HOME_SCREEN: (BuildContext context) => Login(),
    },
  ));
}
