import 'dart:convert';

// import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_directions_api/google_directions_api.dart' hide Distance;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google%20map_states.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_events.dart';
import 'package:tawsela_app/models/data_models/location_model/location.dart';
import 'package:tawsela_app/models/data_models/path_model/path.dart';

class GoogleMapBloc extends Bloc<GoogleMapEvent, GoogleMapState> {
  GoogleMapBloc()
      : super(GoogleMapState(LatLng(0.0, 0.0), <Polyline>[], <Marker>{},
            Path_t.invalid(), null)) {
    on<GoogleMapGetCurrentPosition>((event, emit) async {
      LatLng position = await getCurrentPosition();
      emit(GoogleMapState(
          position,
          <Polyline>[],
          <Marker>{
            const Marker(
                markerId: MarkerId('my-pos'),
                icon: BitmapDescriptor.defaultMarker)
          },
          this.state.pathData,
          this.state.controller));
      // this.state.controller!.moveCamera(CameraUpdate.newCameraPosition(
      //     CameraPosition(target: position, zoom: 200)));
    });
    on<GoogleMapGetPath>((event, emit) async {
      Polyline path = await GoogleMapGetCurrentPath();
      Set<Polyline> lines = <Polyline>{};
      lines.add(path);
      lines.addAll(state.lines);
      emit(GoogleMapState(this.state.currentPosition, List.of(lines),
          this.state.markers, this.state.pathData, this.state.controller));
    });
    on<GoogleMapline>((event, emit) async {
      List<Location_t> locations = await GoogleMapGetCurrentlinePoints();
      Set<Polyline> lines = Set();
      lines.addAll(this.state.lines);
      lines.add(Polyline(
          color: Colors.blue,
          polylineId: PolylineId('line'),
          points:
              locations.map((e) => LatLng(e.latitude, e.longitude)).toList()));
      emit(GoogleMapState(this.state.currentPosition, List.of(lines),
          this.state.markers, this.state.pathData, this.state.controller));
    });
  }

  Future<LatLng> getCurrentPosition() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Denied access to geolocation';
      }
      Position position = await Geolocator.getCurrentPosition();
      return LatLng(position.latitude, position.longitude);
    } catch (exception) {
      print('Exception in googleMap get currentLocation: $exception');
    }
    return LatLng(-1, -1);
  }

  Future<Polyline> GoogleMapGetCurrentPath() async {
    print(
        'currentPosition = ${this.state.currentPosition.latitude},${this.state.currentPosition.longitude}');
    List<LatLng> linePoints = this
        .state
        .lines
        .where((element) => element.polylineId.value == 'line')
        .toList()[0]
        .points;
    print('lines Points length' + linePoints.length.toString());
    int minIndex = 0;
    const int batchSize = 20;
    Path_t minPath = Path_t.invalid();
    for (int batch = 0;
        batch <
            (linePoints.length / batchSize)
                .ceil(); // (linePoints.length / batchSize).ceil();
        batch++) {
      String destinationParameter = '';
      for (int i = batch * batchSize;
          i < ((batch + 1) * batchSize) && i < linePoints.length;
          i++) {
        destinationParameter +=
            '${linePoints[i].latitude},${linePoints[i].longitude}%7C';
      }
      http.Response? response;
      try {
        response = await http.get(Uri.parse(
            'https://maps.googleapis.com/maps/api/distancematrix/json?regionCode=eg&mode=transit&destinations=$destinationParameter&origins=${this.state.currentPosition.latitude},${this.state.currentPosition.longitude}&key=***REMOVED***'));
      } catch (exception) {
        print('Map exception: $exception --- failed at batch $batch');
      }
      Map responseBody = jsonDecode(response!.body);
      List rows = responseBody['rows'];
      print(responseBody);
      print('passed---');
      print(responseBody['error_message']);
      if (rows.length == 0) {
        print('faild at batch $batch');
        // print('status message = ' + responsestatusMessage.toString());
        print(responseBody);
      }
      if (rows.length != 0) {
        List paths = responseBody['rows'][0]['elements'];
        List<Path_t> distances = paths.map((e) => Path_t.fromJson(e)).toList();
        int index = getMinPathIndex(distances);
        if (minPath.distance.value > distances[index].distance.value ||
            minPath.distance.value == -1) {
          print('minPath now = ' + minPath.distance.value.toString());
          minPath = distances[index];
          minIndex = (batch * batchSize) + index;
        }
      }
    }
    DirectionsService.init('***REMOVED***');
    DirectionsService directions = DirectionsService();
    Polyline path = Polyline(
        polylineId: PolylineId('path'),
        color: Colors.green,
        width: 4,
        points: []);
    await directions.route(
        DirectionsRequest(
            // optimizeWaypoints: true,
            alternatives: false,
            travelMode: TravelMode.walking,
            origin:
                '${this.state.currentPosition.latitude},${state.currentPosition.longitude}',
            destination:
                '${linePoints[minIndex].latitude},${linePoints[minIndex].longitude}'),
        (result, status) {
      if (status == DirectionsStatus.ok) {
        print(result.routes![0].legs![0].steps![0].instructions);
        path.points.addAll(result.routes![0].overviewPath!
            .map((e) => LatLng(e.latitude, e.longitude))
            .toList());
      }
    });
    return path;
  }

  int getMinPathIndex(List<Path_t> paths) {
    int minIndex = 0;
    for (int i = 1; i < paths.length; i++) {
      if (paths[i].distance.value < paths[minIndex].distance.value) {
        minIndex = i;
      }
    }
    return minIndex;
  }

  Future<List<Location_t>> GoogleMapGetCurrentlinePoints() async {
    List<Location_t> locations = [];
    try {
      String points =
          await rootBundle.loadString('assets/JSON/Masslla_path.json');
      var json = jsonDecode(points) as Map;
      List snappedPoints = json["snappedPoints"];
      locations = snappedPoints.map((e) {
        return Location_t.FromJson(e['location']);
      }).toList();
      print('item-length = ' + locations.length.toString());
    } catch (exception) {
      print('Exception in GoogleMapGetlinePoints: $exception');
    }
    return locations;
  }
}
