import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'src/locations.dart' as locations;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Marker _marker = Marker(markerId: MarkerId('555'));
  Position _position = Position(longitude: 0, latitude: 0);
  Geolocator geolocator = Geolocator();
  LocationOptions locationOptions = LocationOptions(
      accuracy: LocationAccuracy.best, distanceFilter: 0, timeInterval: 5000);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Google Office Locations'),
            backgroundColor: Colors.green[700],
          ),
          body: Stack(
            children: <Widget>[
              GoogleMap(
                // onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: const LatLng(0, 0),
                  zoom: 2,
                ),
                markers: [_marker].toSet(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  color: Colors.white70,
                  child: StreamBuilder(
                    stream: geolocator.getPositionStream(locationOptions),
                    builder: (context, AsyncSnapshot<Position> snapshot) {
                      print(snapshot.data.speed);
                      print(snapshot.data.speedAccuracy);
                      print('-------------------------');
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('latitude: ${snapshot.data.latitude}'),
                          Text('longitude: ${snapshot.data.longitude}'),
                          Text('altitude: ${snapshot.data.altitude}'),
                          Text('heading: ${snapshot.data.heading}'),
                          Text('speed: ${snapshot.data.speed}'),
                          Text('speedAccuracy: ${snapshot.data.speedAccuracy}'),
                        ],
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
