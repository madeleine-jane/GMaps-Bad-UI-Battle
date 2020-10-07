import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());



class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: MapSample(
        ),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  double latitude = 40.251812345;

  static final CameraPosition _kBYU = CameraPosition(
    target: LatLng(40.2518, -111.6493),
    zoom: 14,
  );
  @override
  Widget build(BuildContext context) {
    String latStr = latitude.toString();
    latStr = latStr.substring(0, latStr.indexOf(".")) + latStr.substring(latStr.indexOf(".") + 1, latStr.length - 1);

    String phoneNum = "";
    phoneNum += "(";
    phoneNum += latStr.substring(0, 3);
    phoneNum += ") ";
    phoneNum += latStr.substring(3, 6);
    phoneNum += "-";
    phoneNum += latStr.substring(6, 10);

    return new Scaffold(
      body: Column (children:[
        Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 40, bottom: 20),
            width: double.infinity,
            child: (
          Center (
            child: Text (
                "Please scroll to the latitude with the value of your phone number:",
              textAlign: TextAlign.center,
              style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: Colors.grey[700]
                ),
              )
        )
          )
        ),
        Container(
        height: 400,
        child: (
            GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _kBYU,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              //markers: Set<Marker>.of(markers),
              onCameraMove: (position) {
                setState(() {
                  latitude = position.target.latitude;
                });
              },
        )
        )
      ),
        Container(
            margin: const EdgeInsets.only(top: 20),
            child: Center(
              child: Text (
                phoneNum,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Colors.grey[700]
                ),
              )
          )
        ),
      ])
    );
  }
}