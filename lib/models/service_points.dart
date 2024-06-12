import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum SORT_SEARCH_OPTION { LATITUDE, LONGITUDE }

class ServicePoints {
  static List<List<LatLng>> serviceLatPoints = [];
  static List<List<LatLng>> serviceLngPoints = [];
  static const List<String> lines = [
    'assets/JSON/paths/3.json',
    'assets/JSON/paths/7.json',
    'assets/JSON/paths/9.json',
    'assets/JSON/paths/11.json'
  ];

  // getters

  // load service lines from json files
  static Future<void> loadLines({bool sorted = false}) async {
    serviceLatPoints = [];
    serviceLngPoints = [];
    // for each path of a file load file
    for (int i = 0; i < lines.length; i++) {
      // load file data from path
      String points = await rootBundle.loadString(lines[i]);
      // convert json string into json object
      var json = jsonDecode(points) as Map;
      // extract points form json object
      List snappedPoints = json["snappedPoints"];
      // getting longitude and latitude of each point in snapped point
      List<LatLng> line = snappedPoints.map((e) {
        return LatLng(e["location"]["latitude"], e["location"]["longitude"]);
      }).toList();
      // sort points by latitude and adding it to serviceLatPoints
      if (sorted) _sort(points: line, option: SORT_SEARCH_OPTION.LATITUDE);
      serviceLatPoints.add(line);

      // sort points by longitude and adding it to serviceLngPoints
      if (sorted) _sort(points: line, option: SORT_SEARCH_OPTION.LATITUDE);
      serviceLngPoints.add(line);
    }
  }

  static void _sort(
      {SORT_SEARCH_OPTION option = SORT_SEARCH_OPTION.LATITUDE,
      required List<LatLng> points}) {
    // performing sorting on points by latitude
    for (int i = 0; i < points.length - 1; i++) {
      for (int j = i + 1; j < points.length; j++) {
        if (option == SORT_SEARCH_OPTION.LATITUDE) {
          if (points[i].latitude > points[j].latitude) {
            LatLng temp = points[i];
            points[i] = points[j];
            points[j] = temp;
          }
        } else {
          if (points[i].longitude > points[j].longitude) {
            LatLng temp = points[i];
            points[i] = points[j];
            points[j] = temp;
          }
        }
      }
    }
  }

  static LatLng LatLngBinarySearch(
      {SORT_SEARCH_OPTION option = SORT_SEARCH_OPTION.LATITUDE,
      required LatLng point,
      required List<LatLng> points}) {
    int start = 0;
    int end = points.length - 1;
    double error = 100000;
    LatLng mostApproximateValue = LatLng(-1, -1);
    while (start <= end) {
      int middle = (start + end) ~/ 2;
      if (option == SORT_SEARCH_OPTION.LATITUDE) {
        // check error of the point to get better estimation
        if (error == 100000 && // check if it is initial state
            mostApproximateValue.latitude == -1 &&
            mostApproximateValue.longitude == -1) {
          mostApproximateValue = points[middle];
          error =
              (points[middle].latitude - mostApproximateValue.latitude).abs();
        }
        // if new error is smaller than the old error
        else if ((points[middle].latitude - point.latitude).abs() < error) {
          mostApproximateValue = points[middle];
          error =
              (points[middle].latitude - mostApproximateValue.latitude).abs();
        }

        // ordinary binary search steps
        if (points[middle].latitude < point.latitude) {
          start = middle + 1;
        } else if (points[middle].latitude > point.latitude) {
          end = middle - 1;
        } else {
          mostApproximateValue = points[middle];
          break;
        }
      } else {
        // same sequence but for option longitude
        if (error == 100000 &&
            mostApproximateValue.latitude == -1 &&
            mostApproximateValue.longitude == -1) {
          mostApproximateValue = points[middle];
          error =
              (points[middle].longitude - mostApproximateValue.longitude).abs();
        } else if ((points[middle].longitude - point.longitude).abs() < error) {
          mostApproximateValue = points[middle];
          error =
              (points[middle].longitude - mostApproximateValue.longitude).abs();
        }

        // binary search steps
        if (points[middle].longitude < point.longitude) {
          start = middle + 1;
        } else if (points[middle].longitude > point.longitude) {
          end = middle - 1;
        } else {
          mostApproximateValue = points[middle];
          break;
        }
      }
    }
    return mostApproximateValue;
  }
}
