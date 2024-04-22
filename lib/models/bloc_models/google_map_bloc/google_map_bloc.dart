import 'dart:async';

// import 'package:dio/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_directions_api/google_directions_api.dart' hide Distance;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google%20map_states.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_events.dart';
import 'package:tawsela_app/models/data_base.dart';
import 'package:tawsela_app/models/data_models/path_model/path.dart';
import 'package:tawsela_app/models/data_models/request_model.dart';
import 'package:tawsela_app/models/data_models/user_data.dart';
import 'package:tawsela_app/models/data_models/user_states.dart';

Future<LatLng> getCurrentPosition() async {
  try {
    LocationPermission permission = await Geolocator.requestPermission();
    while (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    Position position = await Geolocator.getCurrentPosition();
    return LatLng(position.latitude, position.longitude);
  } catch (exception) {
    return const LatLng(-1, -1);
  }
}

Future<GoogleMapState> onGetCurrentPosition() async {
  LatLng position = await getCurrentPosition();
  List<Placemark> places =
      await placemarkFromCoordinates(position.latitude, position.longitude);
  String description = places[0].name ?? 'Unknown';
  return GoogleMapState(
      controller: null,
      currentPosition: position,
      lines: <Polyline>[],
      markers: <Marker>{
        Marker(
            markerId: MarkerId('my-pos'),
            icon: BitmapDescriptor.defaultMarker,
            position: position)
      },
      pathData: Path_t.invalid(),
      currentLocationDescription: description,
      directions: []);
}

class GoogleMapBloc extends Bloc<GoogleMapEvent, GoogleMapState> {
  GoogleMapBloc()
      : super(GoogleMapState(
            currentPosition: const LatLng(0.0, 0.0),
            lines: <Polyline>[],
            markers: <Marker>{},
            pathData: Path_t.invalid(),
            controller: null,
            directions: const [])) {
    //  ************** get current Position *******************

    // ************** switch mode **********************

// *************** get Destination *****************

    //   on<GoogleMapline>((event, emit) async {
    //     List<Location_t> locations = await GoogleMapGetCurrentlinePoints();
    //     Set<Polyline> lines = Set();
    //     lines.addAll(this.state.lines);
    //     lines.add(Polyline(
    //         color: Colors.blue,
    //         polylineId: PolylineId('line'),
    //         points:
    //             locations.map((e) => LatLng(e.latitude, e.longitude)).toList()));
    //     emit(GoogleMapState(
    //         currentPosition: this.state.currentPosition,
    //         lines: List.of(lines),
    //         markers: this.state.markers,
    //         pathData: this.state.pathData,
    //         controller: this.state.controller,
    //         directions: []));
    //   });
    // }

    // Future<Map<String, dynamic>> GoogleMapGetCurrentPath() async {
    //   print(
    //       'currentPosition = ${this.state.currentPosition.latitude},${this.state.currentPosition.longitude}');
    //   List<LatLng> linePoints = this
    //       .state
    //       .lines
    //       .where((element) => element.polylineId.value == 'line')
    //       .toList()[0]
    //       .points;
    //   print('lines Points length' + linePoints.length.toString());
    //   int minIndex = 0;
    //   const int batchSize = 20;
    //   Path_t minPath = Path_t.invalid();
    //   for (int batch = 0;
    //       batch <
    //           (linePoints.length / batchSize)
    //               .ceil(); // (linePoints.length / batchSize).ceil();
    //       batch++) {
    //     String destinationParameter = '';
    //     for (int i = batch * batchSize;
    //         i < ((batch + 1) * batchSize) && i < linePoints.length;
    //         i++) {
    //       destinationParameter +=
    //           '${linePoints[i].latitude},${linePoints[i].longitude}%7C';
    //     }
    //     http.Response? response;
    //     try {
    //       response = await http.get(Uri.parse(
    //           'https://maps.googleapis.com/maps/api/distancematrix/json?regionCode=eg&mode=transit&destinations=$destinationParameter&origins=${this.state.currentPosition.latitude},${this.state.currentPosition.longitude}&key=***REMOVED***'));
    //     } catch (exception) {
    //       print('Map exception: $exception --- failed at batch $batch');
    //     }
    //     Map responseBody = jsonDecode(response!.body);
    //     List rows = responseBody['rows'];
    //     print(responseBody);
    //     print('passed---');
    //     print(responseBody['error_message']);
    //     if (rows.length == 0) {
    //       print('faild at batch $batch');
    //       // print('status message = ' + responsestatusMessage.toString());
    //       print(responseBody);
    //     }
    //     if (rows.length != 0) {
    //       List paths = responseBody['rows'][0]['elements'];
    //       List<Path_t> distances = paths.map((e) => Path_t.fromJson(e)).toList();
    //       int index = getMinPathIndex(distances);
    //       if (minPath.distance.value > distances[index].distance.value ||
    //           minPath.distance.value == -1) {
    //         print('minPath now = ' + minPath.distance.value.toString());
    //         minPath = distances[index];
    //         minIndex = (batch * batchSize) + index;
    //       }
    //     }
    //   }

    //   return {'path': path, 'directions': steps};
    // }

    // int getMinPathIndex(List<Path_t> paths) {
    //   int minIndex = 0;
    //   for (int i = 1; i < paths.length; i++) {
    //     if (paths[i].distance.value < paths[minIndex].distance.value) {
    //       minIndex = i;
    //     }
    //   }
    //   return minIndex;
    // }

    // Future<List<Location_t>> GoogleMapGetCurrentlinePoints() async {
    //   List<Location_t> locations = [];
    //   try {
    //     String points =
    //         await rootBundle.loadString('assets/JSON/Masslla_path.json');
    //     var json = jsonDecode(points) as Map;
    //     List snappedPoints = json["snappedPoints"];
    //     locations = snappedPoints.map((e) {
    //       return Location_t.FromJson(e['location']);
    //     }).toList();
    //     print('item-length = ' + locations.length.toString());
    //   } catch (exception) {
    //     print('Exception in GoogleMapGetlinePoints: $exception');
    //   }
    //   return locations;
    // }
  }
}

class PassengerBloc extends Bloc<GoogleMapEvent, PassengerState> {
  PassengerBloc()
      : super(PassengerState(
            passengerData: Passenger(
                location: LatLng(0.0, 0.0), name: 'Unkown', phone: '#'),
            currentPosition: const LatLng(0.0, 0.0),
            lines: <Polyline>[],
            markers: <Marker>{},
            pathData: Path_t.invalid(),
            controller: null,
            directions: const [])) {
    FutureOr<void> onGetDestination(
        GetDestination event, Emitter<PassengerState> emit) async {
      if (event.destination != state.destination) {
        Set<Marker> newMarkers = [
          state.markers
              .firstWhere((element) => element.markerId.value == 'my-pos')
        ].toSet();
        newMarkers.add(Marker(
            markerId: const MarkerId('destination'),
            position: event.destination,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen)));
        emit(PassengerState(
            currentPosition: state.currentPosition,
            lines: [],
            markers: newMarkers,
            pathData: state.pathData,
            controller: state.controller,
            directions: [],
            currentLocationDescription: state.currentLocationDescription,
            destinationDescription: event.destinationDescription,
            destination: event.destination,
            passengerData: state.passengerData));
        await state.controller!.moveCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: event.destination, zoom: 70)));
      }
    }

    on<GetDestination>(onGetDestination);

    // *********** request Uber Driver **********************

    FutureOr<void> requestUberDriver(
        RequestUberDriver event, Emitter<GoogleMapState> emit) {
      emit(PassengerState(
          currentPosition: state.currentPosition,
          lines: [],
          markers: state.markers,
          pathData: state.pathData,
          controller: state.controller,
          directions: [],
          destination: state.destination,
          currentLocationDescription: state.currentLocationDescription,
          destinationDescription: state.destinationDescription,
          passengerData: state.passengerData));
    }

    on<RequestUberDriver>(requestUberDriver);

    // ************** get nearest path to service line ************

    FutureOr<void> getNearestPathToServiceLine(
        GetNearestPathToServiceLine event, Emitter<GoogleMapState> emit) {}

    on<GetNearestPathToServiceLine>((event, emit) async {
      // Map result = await GoogleMapGetCurrentPath();
      // Polyline path = result['path'];
      // Set<Polyline> lines = <Polyline>{};
      // lines.add(path);
      // lines.addAll(state.lines);
      // emit(GoogleMapState(
      //     currentPosition: this.state.currentPosition,
      //     lines: List.of(lines),
      //     markers: this.state.markers,
      //     pathData: this.state.pathData,
      //     controller: this.state.controller,
      //     directions: result['directions']));
    });

    FutureOr<void> getWalkDirections(
        GetWalkDirections event, Emitter<GoogleMapState> emit) async {
      DirectionsService.init('***REMOVED***');
      DirectionsService directions = DirectionsService();
      Polyline path = Polyline(
          polylineId: PolylineId('path'),
          color: Colors.green,
          width: 4,
          points: []);
      List<Step> steps = [];
      await directions.route(
          DirectionsRequest(
              language: 'ar',
              optimizeWaypoints: true,
              alternatives: false,
              travelMode: TravelMode.walking,
              origin:
                  '${state.currentPosition.latitude},${state.currentPosition.longitude}',
              destination:
                  '${state.destination!.latitude},${state.destination!.longitude}'),
          (result, status) {
        if (status == DirectionsStatus.ok) {
          steps.addAll(result.routes![0].legs![0].steps!);
          path.points.addAll(result.routes![0].overviewPath!
              .map((e) => LatLng(e.latitude, e.longitude))
              .toList());
        }
      });
      List<Polyline> newLines = [];
      newLines.addAll([path]);
      emit(PassengerState(
          currentPosition: state.currentPosition,
          lines: newLines,
          markers: state.markers,
          pathData: state.pathData,
          controller: state.controller,
          directions: steps,
          destination: state.destination,
          destinationDescription: state.destinationDescription,
          currentLocationDescription: state.currentLocationDescription,
          passengerData: state.passengerData));
    }

    on<GetWalkDirections>(getWalkDirections);

    FutureOr<void> getPassengerLocation(
        GoogleMapGetCurrentPosition event, Emitter<PassengerState> emit) async {
      GoogleMapState temp = await onGetCurrentPosition();
      await state.controller!.moveCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: temp.currentPosition, zoom: 50)));
      emit(PassengerState(
          controller: state.controller,
          currentPosition: temp.currentPosition,
          lines: [],
          currentLocationDescription: temp.currentLocationDescription,
          destination: state.destination,
          destinationDescription: state.destinationDescription,
          markers: temp.markers,
          pathData: state.pathData,
          directions: [],
          passengerData: state.passengerData));
    }

    on<GoogleMapGetCurrentPosition>(getPassengerLocation);
  }
}

class UberDriverBloc extends Bloc<GoogleMapEvent, UberDriverState> {
  UberDriverBloc()
      : super(UberDriverState(
            controller: null,
            userState: UserState.DRIVER,
            currentPosition: LatLng(-1, -1),
            lines: [],
            markers: {},
            pathData: Path_t.invalid(),
            directions: [],
            driver:
                UberDriver(name: 'name', location: LatLng(0, 0), phone: '#'))) {
    FutureOr<void> getDriverLocation(GoogleMapGetCurrentPosition event,
        Emitter<UberDriverState> emit) async {
      GoogleMapState temp = await onGetCurrentPosition();
      state.controller!.moveCamera(CameraUpdate.newCameraPosition(
          CameraPosition(zoom: 150, target: temp.currentPosition)));

      emit(UberDriverState(
          controller: state.controller,
          currentPosition: temp.currentPosition,
          lines: [],
          currentLocationDescription: temp.currentLocationDescription,
          destination: state.destination,
          destinationDescription: state.destinationDescription,
          markers: temp.markers,
          pathData: state.pathData,
          directions: [],
          driver: state.driver,
          passengerRequests: state.passengerRequests,
          userState: UserState.DRIVER));
    }

    on<GoogleMapGetCurrentPosition>(getDriverLocation);

    on<GetDestination>((event, emit) {
      state.controller!.moveCamera(CameraUpdate.newCameraPosition(
          CameraPosition(zoom: 50, target: event.destination)));
      Set<Marker> newMarkers = {
        ...state.markers,
        Marker(
            markerId: MarkerId('${event.destination}'),
            position: event.destination,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen)),
      };
      UberDriverState(
          controller: state.controller,
          currentPosition: state.currentPosition,
          lines: [],
          currentLocationDescription: state.currentLocationDescription,
          destination: event.destination,
          destinationDescription: state.destinationDescription,
          markers: newMarkers,
          pathData: state.pathData,
          directions: [],
          passengerRequests: state.passengerRequests,
          driver: state.driver,
          userState: UserState.DRIVER);
    });

    on<GetPassengerRequests>((event, emit) => emit(UberDriverState(
        controller: state.controller,
        currentPosition: state.currentPosition,
        lines: state.lines,
        currentLocationDescription: state.currentLocationDescription,
        destination: state.destination,
        destinationDescription: state.destinationDescription,
        markers: state.markers,
        pathData: state.pathData,
        directions: state.directions,
        passengerRequests: [...userRequests],
        driver: state.driver,
        userState: UserState.DRIVER)));
    on<AcceptPassengerRequest>((event, emit) {
      userRequests
          .removeWhere((element) => element.id == event.passengerRequest.id);
      List<UserRequest> newList = [...userRequests];
      event.passengerRequest.driver = UberDriver(
          name: 'Mohamed',
          location: state.currentPosition,
          phone: '01010625272');
      acceptedRequest.add(event.passengerRequest);
      emit(UberDriverState(
          controller: state.controller,
          currentPosition: state.currentPosition,
          lines: state.lines,
          currentLocationDescription: state.currentLocationDescription,
          destination: state.destination,
          destinationDescription: state.destinationDescription,
          markers: state.markers,
          pathData: state.pathData,
          directions: state.directions,
          passengerRequests: newList,
          driver: state.driver,
          acceptedRequest: event.passengerRequest,
          userState: UserState.DRIVER));
    });
    on<RejectPassengerRequest>((event, emit) {
      userRequests
          .removeWhere((element) => element.id == event.passengerRequest.id);
      List<UserRequest> newList = [...userRequests];
      event.passengerRequest.driver = null;

      event.passengerRequest.driver = state.driver;
      rejectedRequest.add(event.passengerRequest);
      emit(UberDriverState(
          controller: state.controller,
          currentPosition: state.currentPosition,
          lines: state.lines,
          currentLocationDescription: state.currentLocationDescription,
          destination: state.destination,
          destinationDescription: state.destinationDescription,
          markers: state.markers,
          pathData: state.pathData,
          directions: state.directions,
          passengerRequests: newList,
          driver: state.driver,
          acceptedRequest: null,
          userState: UserState.DRIVER));
    });
    on<GetPassengerDirections>((event, emit) async {
      state.controller!.moveCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              zoom: 50, target: state.acceptedRequest!.passengerLocation)));
      Set<Marker> newMarkers = {
        ...state.markers,
        Marker(
            markerId: MarkerId('${state.acceptedRequest!.passengerLocation}'),
            position: state.acceptedRequest!.passengerLocation,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen)),
      };

      DirectionsService.init('***REMOVED***');
      DirectionsService directions = DirectionsService();
      Polyline path = Polyline(
          polylineId: PolylineId('path'),
          color: Colors.green,
          width: 4,
          points: []);
      List<Step> steps = [];
      await directions.route(
          DirectionsRequest(
              language: 'ar',
              optimizeWaypoints: true,
              alternatives: false,
              travelMode: TravelMode.driving,
              origin:
                  '${state.currentPosition.latitude},${state.currentPosition.longitude}',
              destination:
                  '${state.acceptedRequest!.passengerLocation.latitude},${state.acceptedRequest!.passengerLocation.longitude}'),
          (result, status) {
        if (status == DirectionsStatus.ok) {
          steps.addAll(result.routes![0].legs![0].steps!);
          path.points.addAll(result.routes![0].overviewPath!
              .map((e) => LatLng(e.latitude, e.longitude))
              .toList());
        }
      });
      List<Polyline> newLines = [];
      newLines.addAll([path]);
      emit(UberDriverState(
          currentPosition: state.currentPosition,
          lines: newLines,
          markers: newMarkers,
          pathData: state.pathData,
          controller: state.controller,
          directions: steps,
          destination: state.acceptedRequest!.passengerLocation,
          destinationDescription:
              state.acceptedRequest!.currentLocationDescription,
          currentLocationDescription: state.currentLocationDescription,
          driver: state.driver,
          userState: UserState.DRIVER,
          acceptedRequest: state.acceptedRequest,
          passengerRequests: state.passengerRequests));
    });

    on<CancelTrip>((event, emit) {
      Set<Marker> newMarkers = {
        ...state.markers.where((element) => element.markerId.value == 'my-pos')
      };
      event.passengerRequest.driver = null;
      userRequests.add(event.passengerRequest);
      event.passengerRequest.driver = state.driver;
      canceledTrips.add(event.passengerRequest);
      emit(UberDriverState(
          currentPosition: state.currentPosition,
          lines: [],
          markers: newMarkers,
          pathData: state.pathData,
          controller: state.controller,
          directions: [],
          destination: null,
          destinationDescription: 'Unknown',
          currentLocationDescription: 'Unknown',
          driver: state.driver,
          userState: UserState.DRIVER,
          acceptedRequest: null,
          passengerRequests: state.passengerRequests));
    });
    on<StartTrip>((event, emit) {
      userRequests
          .removeWhere((element) => element.id == event.passengerRequest.id);
      startedTrips.add(event.passengerRequest);
      emit(UberDriverState(
          currentPosition: state.currentPosition,
          lines: state.lines,
          markers: state.markers,
          pathData: state.pathData,
          controller: state.controller,
          directions: state.directions,
          destination: state.destination,
          destinationDescription: state.destinationDescription,
          currentLocationDescription: state.currentLocationDescription,
          driver: state.driver,
          userState: UserState.DRIVER,
          acceptedRequest: state.acceptedRequest,
          passengerRequests: userRequests));
    });
    on<EndTrip>((event, emit) {
      endedTrips.add(event.passengerRequest);
      startedTrips
          .removeWhere((element) => element.id == event.passengerRequest.id);
      emit(UberDriverState(
          currentPosition: state.currentPosition,
          lines: [],
          markers: state.markers,
          pathData: state.pathData,
          controller: state.controller,
          directions: state.directions,
          destination: state.destination,
          destinationDescription: state.destinationDescription,
          currentLocationDescription: state.currentLocationDescription,
          driver: state.driver,
          userState: UserState.DRIVER,
          acceptedRequest: null,
          passengerRequests: state.passengerRequests));
    });
  }
}
