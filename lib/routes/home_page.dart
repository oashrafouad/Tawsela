import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Scaffold(
        body: GoogleMap(
      initialCameraPosition: CameraPosition(target: LatLng(29, 32), zoom: 100),
    ));
  }
}
