import 'dart:async';
import 'dart:convert';

// import 'package:dio/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_directions_api/google_directions_api.dart' hide Distance;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google%20map_states.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_events.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_place_holder.dart';
import 'package:tawsela_app/models/data_models/uber_driver.dart';
import 'package:tawsela_app/models/servers/google_server.dart';

import 'package:tawsela_app/models/data_models/passenger.dart';
import 'package:tawsela_app/models/data_models/path_model/path.dart';

import 'package:connectivity/connectivity.dart';
import 'package:tawsela_app/models/servers/main_server.dart';
import 'package:tawsela_app/models/service_points.dart';
import 'package:tawsela_app/models/uber_driver_bloc/uber_driver_bloc.dart';
import 'package:tawsela_app/models/passenger_bloc/passenger_events.dart';
import 'package:tawsela_app/models/passenger_bloc/passenger_states.dart';

const String getServiceLinePlacHolder = 'Getting Nearest service Line';
const String getDestinationPlaceHolder = 'Getting destination';
const String getPassengerLocationPlacHolder = 'getting current Location';

const List<Color> lineColor = [
  Colors.green,
  Colors.blue,
  Colors.red,
  Colors.yellow,
];

PassengerState passengerLastState = PassengerState(
    passengerData: Passenger(
        lastName: 'Unknown',
        email: 'Hello ahmed',
        age: 17,
        location: invalidPosition,
        firstName: 'Unkown',
        phone: '#'),
    currentPosition: invalidPosition,
    lines: <Polyline>[],
    markers: <Marker>{},
    controller: null,
    directions: const []);

class PassengerBloc extends Bloc<GoogleMapEvent, MapUserState> {
  // get passenger destination -- begin
  FutureOr<void> onGetDestination(
      GetDestination event, Emitter<MapUserState> emit) async {
    emit(const Loading(getDestinationPlaceHolder));
    final permission = Geolocator.requestPermission();
    final connectivity = Connectivity().checkConnectivity();
    if (permission == LocationPermission.denied) {
      emit(const UserErrorState('Please open location service'));
    } else if (connectivity == ConnectivityResult.none) {
      emit(const UserErrorState('Check your internet Connection'));
    } else if (state is UserErrorState ||
        state is PassengerState ||
        state is Loading) {
      if (event.destination == passengerLastState.destination) {
        emit(const UserErrorState('It is the same destination'));
      } else if (passengerLastState.currentPosition.latitude ==
              invalidPosition.latitude &&
          passengerLastState.currentPosition.longitude ==
              invalidPosition.longitude) {
        emit(const UserErrorState('Please Provide current Location'));
      } else {
        Set<Marker> newMarkers = passengerLastState.markers;
        newMarkers.removeWhere(
            (element) => element.markerId.value == destinationMarkerId);

        newMarkers.add(Marker(
            markerId: const MarkerId(destinationMarkerId),
            position: event.destination,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen)));
        final newState = PassengerState(
            currentPosition: passengerLastState.currentPosition,
            lines: [],
            markers: newMarkers,
            controller: passengerLastState.controller,
            directions: [],
            destination: event.destination,
            currentLocationDescription:
                passengerLastState.currentLocationDescription,
            destinationDescription: event.destinationDescription,
            passengerData: passengerLastState.passengerData);
        passengerLastState = newState;
        emit(newState);
        await passengerLastState.controller!.animateCamera(
            CameraUpdate.newCameraPosition(
                CameraPosition(target: event.destination, zoom: 100)));
      }
    }
  }

  /************** get passenger destination end  ************************************* */

  // request uber driver begin
  FutureOr<void> requestUberDriver(
      RequestUberDriver event, Emitter<MapUserState> emit) async {
    final permission = await Geolocator.requestPermission();
    final connectivity = await Connectivity().checkConnectivity();
    if (permission == LocationPermission.denied) {
      emit(const UserErrorState('Please open location service'));
    } else if (connectivity == ConnectivityResult.none) {
      emit(const UserErrorState('Check your internet Connection'));
    } else if (state is UserErrorState ||
        state is PassengerState ||
        state is Loading) {
      if (passengerLastState.destination == null) {
        emit(const UserErrorState('please provide destination'));
      } else if (passengerLastState.currentPosition.latitude ==
              invalidPosition.latitude &&
          passengerLastState.currentPosition.longitude ==
              invalidPosition.longitude) {
        emit(const UserErrorState('Please Provide current Location'));
      }
    } else {
      emit(Loading('Searching for nearby drivers'));

      await MainServer.createRequest(request: event.passengerRequest);
      int? isAccepted = null;
      do {
        isAccepted = await MainServer.isAcceptedRequest(
            request_id: event.passengerRequest.Req_ID);
        Future.delayed(Duration(seconds: 5));
      } while (isAccepted == null);

      final newState = PassengerState(
          driverData: UberDriver(
              rating: 0.5,
              firstName: 'Ahmed',
              lastName: 'Ibrahim',
              location: LatLng(0, 0),
              phone: isAccepted.toString(),
              age: 71,
              email: 'akdcbkhaw'),
          currentPosition: passengerLastState.currentPosition,
          lines: [],
          markers: passengerLastState.markers,
          controller: passengerLastState.controller,
          directions: [],
          destination: passengerLastState.destination,
          currentLocationDescription:
              passengerLastState.currentLocationDescription,
          destinationDescription: passengerLastState.destinationDescription,
          passengerData: passengerLastState.passengerData);
      passengerLastState = newState;
      emit(newState);
    }
  }

  /************ request uber driver end *********************** */

  // get Min index begin
  List<int> getMinPathIndex(List<Path_t> paths) {
    List<int> lines = [];
    List<Path_t> points = [];
    for (int i = 0; i < paths.length; i++) {
      if (paths[i].distance.value != null) {
        lines.add(i);
        points.add(paths[i]);
      }
    }
    for (int i = 1; i < points.length; i++) {
      for (int j = 0; j < points.length - 1; j++) {
        if (points[j].distance.value != null &&
            points[j].distance.value != null &&
            points[j].distance.value! > points[j + 1].distance.value!) {
          double temp = points[j].distance.value!;
          points[j].distance.value = points[j + 1].distance.value!;
          points[j + 1].distance.value = temp;

          // sort lines
          int tempLine = lines[j];
          lines[j] = lines[j + 1];
          lines[j + 1] = tempLine;
        }
      }
    }
    return lines;
  }

  /************ get min index end ****************************** */

  // get current service path begin
  FutureOr<void> GoogleMapGetCurrentPath() async {
    emit(const Loading(getServiceLinePlacHolder));
    await ServicePoints.loadLines(sorted: true);

    // NOTE:
    //  latitudeSorted and longitudeSorted are of the same length
    List<List<LatLng>> latitudeSorted = ServicePoints.serviceLatPoints;
    List<List<LatLng>> longitudeSorted = ServicePoints.serviceLatPoints;

    // these list will contain most approximate point to current position from each line
    List<LatLng> minLatitude =
        List.filled(latitudeSorted.length, const LatLng(0, 0));
    List<LatLng> minLongitude =
        List.filled(longitudeSorted.length, const LatLng(0, 0));
    ;
    // get aligned points to user
    for (int i = 0; i < latitudeSorted.length; i++) {
      LatLng latitude = ServicePoints.getNearesPoint(
          point: passengerLastState.destination!,
          line: latitudeSorted[i],
          option: SORT_SEARCH_OPTION.LATITUDE);
      minLatitude[i] = latitude;
      LatLng longitude = ServicePoints.getNearesPoint(
          point: passengerLastState.destination!,
          line: longitudeSorted[i],
          option: SORT_SEARCH_OPTION.LONGITUDE);
      minLongitude[i] = longitude;
    }
    // first line equation
    List<double> slopes = List.filled(minLatitude.length, 0);

    int i = 0;
    while (i < minLatitude.length) {
      slopes[i] = (minLatitude[i].latitude - minLongitude[i].latitude) /
          (minLatitude[i].longitude - minLongitude[i].longitude);

      i += 1;
    }
    // b part of the equation
    List<double> yb = List.filled(slopes.length, 0);
    for (int i = 0; i < minLatitude.length; i += 1) {
      yb[i] = -slopes[i] * minLatitude[i].longitude + minLatitude[i].latitude;
    }
    // perpendicular line
    List<double> perpenSlope = List.filled(slopes.length, 0);
    for (int i = 0; i < slopes.length; i++) {
      perpenSlope[i] = -1 / slopes[i];
    }
    // perpendicular perpenYb
    List<double> perpenYb = List.filled(slopes.length, 0);
    for (int i = 0; i < perpenSlope.length; i++) {
      perpenYb[i] =
          -perpenSlope[i] * passengerLastState.destination!.longitude +
              passengerLastState.destination!.latitude;
    }
    // intersetion points
    List<double> intersectionPoints = List.filled(slopes.length, 0);
    for (int i = 0; i < slopes.length; i++) {
      intersectionPoints[i] =
          (perpenYb[i] - yb[i]) / (slopes[i] - perpenSlope[i]);
    }
    List<LatLng> shortPoints =
        List.filled(intersectionPoints.length, LatLng(0, 0));
    for (int i = 0; i < intersectionPoints.length; i++) {
      shortPoints[i] = LatLng(
          slopes[i] * intersectionPoints[i] + yb[i], intersectionPoints[i]);
    }

    // LatLng minLatitudePoint = minLatitude[0];
    // LatLng minLongitudePoint = minLongitude[0];
    // int minLatitudeIndex = 0;
    // int minLongitudeIndex = 0;
    // double minLatitudeValue = 10000000;
    // double minLongitudeValue = 1000000;
    // for (int i = 0; i < minLatitude.length; i++) {
    //   if ((minLatitude[i].longitude - passengerLastState.destination!.longitude)
    //           .abs() <
    //       minLatitudeValue) {
    //     minLatitudeValue = (minLatitude[i].longitude -
    //             passengerLastState.destination!.longitude)
    //         .abs();
    //     minLatitudePoint = minLatitude[i];
    //     minLatitudeIndex = i;
    //   }
    //   if ((minLongitude[i].latitude - passengerLastState.destination!.latitude)
    //           .abs() <
    //       minLongitudeValue) {
    //     minLongitudeValue = (minLongitude[i].latitude -
    //             passengerLastState.destination!.latitude)
    //         .abs();
    //     minLongitudePoint = minLongitude[i];
    //     minLongitudeIndex = i;
    //   }
    // }
    // initializing values of min algorithm for longitude and latitude
    // int minErrorLatitudeIndex = 0;
    // double minLatitudeError =
    //     (minLatitude[0].latitude - passengerLastState.destination!.latitude)
    //         .abs();
    // int minErrorLongitudeIndex = 0;
    // double minLongitudeError =
    //     (minLongitude[0].longitude - passengerLastState.destination!.longitude)
    //         .abs();
    String destinationParameter = '';
    for (int i = 0; i < shortPoints.length; i++) {
      destinationParameter +=
          '${shortPoints[i].latitude},${shortPoints[i].longitude}%7C';
      // destinationParameter +=
      //     '${minLongitude[i].latitude},${minLongitude[i].longitude}%7C';
    }

    http.Response? response;
    try {
      response = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/distancematrix/json?regionCode=eg&mode=transit&destinations=$destinationParameter&origins=${passengerLastState.destination!.latitude},${passengerLastState.destination!.longitude}&key=${GetIt.instance.get<GoogleServer>().url}'));
    } catch (exception) {
      emit(const UserErrorState('Error caclulating nearest service line'));
    }

    Map responseBody = jsonDecode(response!.body);
    List rows = responseBody['rows'];

    if (rows.length != 0) {
      List paths = responseBody['rows'][0]['elements'];

      print(paths);
      List<Path_t> distances = paths.map((e) {
        if (e['distance'] == null) {
          return Path_t(Distance(null, null), Duration_t(null, null));
        } else {
          return Path_t.fromJson(e);
        }
      }).toList();
      List<int> lines = getMinPathIndex(distances);

      // int row = index ~/ 2;
      // int col = (index % 2 == 0) ? 0 : 1;

      // int lineNumber = (index - col) ~/ 2;
      // if (index % 2 == 0) {
      //   index ~/= 2;
      //   target = minLatitude[index];
      // } else {
      //   index = (index - 1) ~/ 2;
      //   target = minLongitude[index];
      // }

      /*********************************************** */
      int minLine = -1;
      LatLng? userFinalLocalDestination;
      double totalDistance = double.maxFinite;
      for (int i = 0; i < lines.length; i++) {
        double dd = distances[lines[i]].distance.value!;
        double sd = double.maxFinite;

        LatLng latValue = ServicePoints.getNearesPoint(
            option: SORT_SEARCH_OPTION.LATITUDE,
            point: passengerLastState.currentPosition,
            line: ServicePoints.serviceLatPoints[lines[i]]);
        LatLng lngValue = ServicePoints.getNearesPoint(
            option: SORT_SEARCH_OPTION.LONGITUDE,
            point: passengerLastState.currentPosition,
            line: ServicePoints.serviceLngPoints[lines[i]]);

        final double slope = (latValue.latitude - lngValue.latitude) /
            (latValue.longitude - lngValue.longitude);

        final double ybb = -slope * latValue.longitude + latValue.latitude;
        final double pSlope = -1 / slope;
        final double pybb =
            -pSlope * passengerLastState.currentPosition.longitude +
                passengerLastState.currentPosition.latitude;
        final double intersection = (pybb - ybb) / (slope - pSlope);
        LatLng userLocalDestination =
            LatLng(slope * intersection + ybb, intersection);
        final String localDestination =
            '${userLocalDestination.latitude},${userLocalDestination.longitude}%7C';

        try {
          response = await http.get(Uri.parse(
              'https://maps.googleapis.com/maps/api/distancematrix/json?regionCode=eg&mode=walking&destinations=$localDestination&origins=${passengerLastState.currentPosition.latitude},${passengerLastState.currentPosition.longitude}&key=${GetIt.instance.get<GoogleServer>().url}'));
        } catch (exception) {
          emit(UserErrorState('Error caclulating nearest service line'));
        }
        responseBody = jsonDecode(response!.body);
        if (rows.length != 0) {
          List paths = responseBody['rows'][0]['elements'];
          if (paths[0]['distance'] != null) {
            print('one path = ' + paths.toString());
            List<Path_t> distances =
                paths.map((e) => Path_t.fromJson(e)).toList();
            sd = distances[0].distance.value ?? double.maxFinite;
          } else {
            emit(UserErrorState('No Valid path for line ${lines[i]}'));
          }
          if (dd + sd < totalDistance) {
            totalDistance = dd + sd;
            minLine = lines[i];
            userFinalLocalDestination = userLocalDestination;
          }
        }
      }
      add(ShowLine(minLine));
      add(GetWalkDirections(
          passengerDestination:
              userFinalLocalDestination ?? passengerLastState.currentPosition));
      // try {
      //   response = await http.get(Uri.parse(
      //       'https://maps.googleapis.com/maps/api/distancematrix/json?regionCode=eg&mode=transit&destinations=$localDestination&origins=${passengerLastState.currentPosition.latitude},${passengerLastState.currentPosition.longitude}&key=${GetIt.instance.get<GoogleServer>().url}'));
      // } catch (exception) {
      //   emit(UserErrorState('Error caclulating nearest service line'));
      // }
      // responseBody = jsonDecode(response!.body);
      // rows = responseBody['rows'];
      // if (rows.length != 0) {
      //   List paths = responseBody['rows'][0]['elements'];
      //   List<Path_t> distances = paths.map((e) => Path_t.fromJson(e)).toList();
      //   index = getMinPathIndex(distances);
      // } else {
      //   emit(UserErrorState('Error caclulating nearest service line'));
      // }
    }
  }

  /****************** get current service path end ******************************** */

  // get walk direction for passenger begin
  FutureOr<void> getWalkDirections(
      GetWalkDirections event, Emitter<MapUserState> emit) async {
    final permission = await Geolocator.requestPermission();
    final connectivity = await Connectivity().checkConnectivity();
    if (permission == LocationPermission.denied) {
      emit(const UserErrorState('Please open location service'));
    } else if (connectivity == ConnectivityResult.none) {
      emit(const UserErrorState('Check your internet Connection'));
    } else if (state is UserErrorState ||
        state is PassengerState ||
        state is Loading) {
      if (passengerLastState.destination == null) {
        emit(const UserErrorState('Please Provide destination'));
      } else if (passengerLastState.currentPosition.latitude ==
              invalidPosition.latitude &&
          passengerLastState.currentPosition.longitude ==
              invalidPosition.longitude) {
        emit(const UserErrorState('Please Provide current Location'));
      } else {
        try {
          DirectionsService.init(GetIt.instance.get<GoogleServer>().url);
          DirectionsService directions = DirectionsService();
          Polyline path = const Polyline(
              polylineId: PolylineId('path'),
              color: Colors.green,
              width: 4,
              points: []);
          List<Step> steps = [];
          await directions.route(
              DirectionsRequest(
                  language: 'ar',
                  optimizeWaypoints: true,
                  alternatives: true,
                  travelMode: TravelMode.walking,
                  origin:
                      '${passengerLastState.currentPosition.latitude},${passengerLastState.currentPosition.longitude}',
                  destination:
                      '${event.passengerDestination.latitude},${event.passengerDestination.longitude}'),
              (result, status) {
            if (status == DirectionsStatus.ok) {
              steps.addAll(result.routes![0].legs![0].steps!);
              path.points.addAll(result.routes![0].overviewPath!
                  .map((e) => LatLng(e.latitude, e.longitude))
                  .toList());
            }
          });
          List<Polyline> newLines = [];
          newLines.addAll([path, ...passengerLastState.lines]);
          final newState = PassengerState(
              currentPosition: passengerLastState.currentPosition,
              lines: newLines,
              markers: passengerLastState.markers,
              controller: passengerLastState.controller,
              directions: steps,
              destination: passengerLastState.destination,
              destinationDescription: passengerLastState.destinationDescription,
              currentLocationDescription:
                  passengerLastState.currentLocationDescription,
              passengerData: passengerLastState.passengerData);
          passengerLastState = newState;
          emit(newState);
        } catch (exception) {
          emit(UserErrorState('${exception}'));
        }
      }
    } else {
      emit(const UserErrorState('An Error has occured please try again'));
    }
  }

/************* get walk direction for passenger end **************************************** */
  FutureOr<void> getPassengerLocation(
      GoogleMapGetCurrentPosition event, Emitter<MapUserState> emit) async {
    emit(const Loading(getPassengerLocationPlacHolder));
    MapUserState temp = await onGetCurrentPosition();
    if (temp is UserErrorState) {
      emit(temp);
    } else if (temp is GoogleMapState) {
      try {
        final currentState = temp as GoogleMapState;
        await passengerLastState.controller!.animateCamera(
            CameraUpdate.newCameraPosition(CameraPosition(
                target: currentState.currentPosition, zoom: 50)));
        final newState = PassengerState(
            controller: passengerLastState.controller,
            currentPosition: currentState.currentPosition,
            lines: [],
            currentLocationDescription: currentState.currentLocationDescription,
            destination: currentState.destination,
            destinationDescription: currentState.destinationDescription,
            markers: currentState.markers,
            directions: [],
            passengerData: passengerLastState.passengerData);
        passengerLastState = newState;
        emit(newState);
        return;
      } catch (exception) {
        emit(UserErrorState(exception.toString()));
      }
    }
  }

// constructor begin
  PassengerBloc() : super(passengerLastState) {
    on<GetDestination>(onGetDestination);
    on<RequestUberDriver>(requestUberDriver);
    on<GoogleMapGetCurrentPosition>(getPassengerLocation);

    on<GetNearestPathToServiceLine>((event, emit) async {
      final permission = await Geolocator.requestPermission();
      final connectivity = await Connectivity().checkConnectivity();
      if (permission == LocationPermission.denied) {
        emit(const UserErrorState('Please open location service'));
      } else if (connectivity == ConnectivityResult.none) {
        emit(const UserErrorState('Check your internet Connection'));
      } else if (state is UserErrorState ||
          state is PassengerState ||
          state is Loading) {
        if (passengerLastState.destination == null) {
          emit(const UserErrorState('please provide destination'));
        } else if (passengerLastState.currentPosition.latitude ==
                invalidPosition.latitude &&
            passengerLastState.currentPosition.longitude ==
                invalidPosition.longitude) {
          emit(const UserErrorState('Please Provide current Location'));
        } else {
          await GoogleMapGetCurrentPath();
        }
      } else {
        const UserErrorState('An Error has occured');
      }
    });
    on<ShowLine>((event, emit) async {
      await ServicePoints.loadLines();
      List<Polyline> newPloylines = [];

      newPloylines.addAll([
        //...passengerLastState.lines,
        Polyline(
            geodesic: true,
            polylineId: PolylineId(
                ServicePoints.lines[event.lineNumber].split('/').last),
            points: ServicePoints.serviceLatPoints[event.lineNumber],
            startCap: Cap.roundCap,
            color: Colors.blue)
      ]);
      int number;
      switch (event.lineNumber) {
        case 0:
          number = 3;
          break;
        case 1:
          number = 7;
          break;
        case 2:
          number = 9;
          break;
        case 3:
          number = 11;
          break;
        default:
          number = 1;
          break;
      }
      BitmapDescriptor? image;
      await BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(size: Size(5, 5)), 'assets/$number.png')
          .then((value) => image = value);

      Set<Marker> newMarkers = {
        Marker(
            markerId:
                MarkerId(ServicePoints.lines[event.lineNumber].split('/').last),
            infoWindow: InfoWindow(
                title: ServicePoints.lines[event.lineNumber].split('/').last),
            icon: image ?? BitmapDescriptor.defaultMarker,
            position: ServicePoints.serviceLatPoints[event.lineNumber]
                [ServicePoints.serviceLatPoints[event.lineNumber].length ~/ 2]),
        ...(passengerLastState.markers.toList())
      };

      final newState = PassengerState(
          controller: passengerLastState.controller,
          currentPosition: passengerLastState.currentPosition,
          lines: newPloylines,
          currentLocationDescription:
              passengerLastState.currentLocationDescription,
          destination: passengerLastState.destination,
          destinationDescription: passengerLastState.destinationDescription,
          markers: newMarkers,
          directions: passengerLastState.directions,
          passengerData: passengerLastState.passengerData);
      passengerLastState = newState;
      emit(newState);
    });

    on<GetWalkDirections>(getWalkDirections);
  }
}
