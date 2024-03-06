import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: GoogleMap(
      initialCameraPosition: CameraPosition(target: LatLng(29, 32), zoom: 100),
    ));
  }
}
