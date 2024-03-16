import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DistanceMatrixAPI {
  static Future<void> getnearestRoute(
      LatLng origin, List<LatLng> destinations) async {
    String destinationParameter = '';
    for (int i = 0; i < destinations.length; i++) {
      destinationParameter +=
          '${destinations[i].latitude},${destinations[i].longitude}${i == destinations.length - 1 ? "" : "|"}';
    }
    var response = await Dio().getUri(Uri.parse(
        'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=$destinationParameter&origins=${origin.latitude},${origin.longitude}&key=***REMOVED***'));
    print('final');
    print(response.data);
    print(response.data is Map);
  }
}

void main() async {
  test('API Test', () async {
    await DistanceMatrixAPI.getnearestRoute(LatLng(29.3182322, 30.8433461), [
      LatLng(29.315314226178813, 30.852451344537155),
      LatLng(29.31937148907226, 30.831769125706526)
    ]);
  });
}
