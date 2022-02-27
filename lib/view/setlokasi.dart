import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:trust_location/trust_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_permissions/location_permissions.dart';

class SetLokasi extends StatefulWidget {
  @override
  _SetLokasiState createState() => _SetLokasiState();
}

class _SetLokasiState extends State<SetLokasi> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  final Set<Marker> _markers = {};
  String _latitude;
  String _longitude;
  bool _isMockLocation;

  Position _currentPosition;
  String _currentAddress;
  LatLng _position;
  bool _isLoading = false;
  var lat, lng;
  String nik;
  String userid;
  double jarak;
  List array_jarak;

  /// initialize state.
  @override
  void initState() {
    super.initState();
    requestLocationPermission();
  }

  /// get location method, use a try/catch PlatformException.
  Future<void> getLocation() async {
    try {
      if (this.mounted) {
        TrustLocation.onChange.listen((values) => setState(() {
              _latitude = values.latitude;
              _longitude = values.longitude;
              _isMockLocation = values.isMockLocation;
            }));
      }

      _markers.add(
        Marker(
          markerId: MarkerId("${_position.latitude}, ${_position.longitude}"),
          position: _position,
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    } on PlatformException catch (e) {
      print('PlatformException $e');
    }
  }

  /// request location permission at runtime.
  void requestLocationPermission() async {
    PermissionStatus permission =
        await LocationPermissions().requestPermissions();
    print('permissions: $permission');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Trust Location Plugin'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
              child: Column(
            children: <Widget>[
              Text('Mock Location: $_isMockLocation'),
              Text('Latitude: $_latitude, Longitude: $_longitude'),
              new Padding(padding: EdgeInsets.only(bottom: 10.0)),
              FlatButton(
                child: Text(
                  "Search location your ",
                  style: TextStyle(color: Colors.lightBlue),
                ),
                onPressed: () {
                  getLocation();
                },
              ),
              new Container(
                padding: EdgeInsets.all(8.0),
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
                child: lat == null || lng == null
                    ? Container()
                    : GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                          target: _position,
                          zoom: 18.0,
                        ),
                        markers: _markers,
                      ),
              ),
              if (_currentPosition != null)
                new Container(
                    padding: EdgeInsets.all(8.0),
                    child: Text(_currentAddress ?? '')),
            ],
          )),
        ),
      ),
    );
  }
}
