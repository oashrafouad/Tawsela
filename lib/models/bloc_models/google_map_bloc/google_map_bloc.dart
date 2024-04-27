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
import 'package:connectivity/connectivity.dart';

const invalidPosition = LatLng(-1, -1);
const positionMarkerId = 'My-pos';
const destinationMarkerId = 'My-des';
PassengerState passengerLastState = PassengerState(
    passengerData:
        Passenger(location: invalidPosition, name: 'Unkown', phone: '#'),
    currentPosition: invalidPosition,
    lines: <Polyline>[],
    markers: <Marker>{},
    controller: null,
    directions: const []);
UberDriverState uberLastState = UberDriverState(
    controller: null,
    userState: UserState.DRIVER,
    currentPosition: LatLng(-1, -1),
    lines: [],
    markers: {},
    directions: [],
    driver: UberDriver(name: 'name', location: invalidPosition, phone: '#'));
Future<LatLng> getCurrentPosition() async {
  try {
    LocationPermission permission = await Geolocator.requestPermission();
    while (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    Position position = await Geolocator.getCurrentPosition();
    return LatLng(position.latitude, position.longitude);
  } catch (exception) {
    return invalidPosition;
  }
}

Future<MapUserState> onGetCurrentPosition() async {
  final permission = await Geolocator.requestPermission();
  final connectivity = await Connectivity().checkConnectivity();
  if (connectivity == ConnectivityResult.none) {
    return UserErrorState('Check your internet Connection');
  } else if (permission == LocationPermission.denied) {
    return UserErrorState('Please open location service');
  }
  // else if (position.latitude != invalidPosition.latitude &&
  //     position.longitude != invalidPosition.longitude) {
  //   return UserErrorState('Please Provide current Location');
  // }
  else {
    try {
      final LatLng position = await getCurrentPosition();
      List<Placemark> places =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      String description = places[0].name ?? 'Unknown';
      return GoogleMapState(
          controller: null,
          currentPosition: position,
          lines: <Polyline>[],
          markers: <Marker>{
            Marker(
                markerId: MarkerId(positionMarkerId),
                icon: BitmapDescriptor.defaultMarker,
                position: position)
          },
          currentLocationDescription: description,
          directions: []);
    } catch (exception) {
      return UserErrorState('An Error has occured please try again');
    }
  }
}

class GoogleMapBloc extends Bloc<GoogleMapEvent, GoogleMapState> {
  GoogleMapBloc()
      : super(GoogleMapState(
            currentPosition: const LatLng(0.0, 0.0),
            lines: <Polyline>[],
            markers: <Marker>{},
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

class PassengerBloc extends Bloc<GoogleMapEvent, MapUserState> {
  PassengerBloc() : super(passengerLastState) {
    FutureOr<void> onGetDestination(
        GetDestination event, Emitter<MapUserState> emit) async {
      emit(Loading('Getting destination'));
      final permission = Geolocator.requestPermission();
      final connectivity = Connectivity().checkConnectivity();
      if (permission == LocationPermission.denied) {
        emit(UserErrorState('Please open location service'));
      } else if (connectivity == ConnectivityResult.none) {
        emit(UserErrorState('Check your internet Connection'));
      } else if (state is UserErrorState ||
          state is PassengerState ||
          state is Loading) {
        if (event.destination == passengerLastState.destination) {
          emit(UserErrorState('It is the same destination'));
        } else if (passengerLastState.currentPosition.latitude ==
                invalidPosition.latitude &&
            passengerLastState.currentPosition.longitude ==
                invalidPosition.longitude) {
          emit(UserErrorState('Please Provide current Location'));
        } else {
          var newMarkers = passengerLastState.markers;
          newMarkers.removeWhere(
              (element) => element.markerId.value == destinationMarkerId);

          newMarkers.add(Marker(
              markerId: MarkerId(destinationMarkerId),
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

    on<GetDestination>(onGetDestination);

    // *********** request Uber Driver **********************

    FutureOr<void> requestUberDriver(
        RequestUberDriver event, Emitter<MapUserState> emit) async {
      final permission = await Geolocator.requestPermission();
      final connectivity = await Connectivity().checkConnectivity();
      if (permission == LocationPermission.denied) {
        emit(UserErrorState('Please open location service'));
      } else if (connectivity == ConnectivityResult.none) {
        emit(UserErrorState('Check your internet Connection'));
      } else if (state is UserErrorState ||
          state is PassengerState ||
          state is Loading) {
        if (passengerLastState.destination == null) {
          emit(UserErrorState('please provide destination'));
        } else if (passengerLastState.currentPosition.latitude ==
                invalidPosition.latitude &&
            passengerLastState.currentPosition.longitude ==
                invalidPosition.longitude) {
          emit(UserErrorState('Please Provide current Location'));
        }
      } else {
        final newState = PassengerState(
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

    on<RequestUberDriver>(requestUberDriver);

    // ************** get nearest path to service line ************

    FutureOr<void> getNearestPathToServiceLine(
        GetNearestPathToServiceLine event, Emitter<MapUserState> emit) {}

    on<GetNearestPathToServiceLine>((event, emit) async {
      final permission = await Geolocator.requestPermission();
      final connectivity = await Connectivity().checkConnectivity();
      if (permission == LocationPermission.denied) {
        emit(UserErrorState('Please open location service'));
      } else if (connectivity == ConnectivityResult.none) {
        emit(UserErrorState('Check your internet Connection'));
      } else if (state is UserErrorState ||
          state is PassengerState ||
          state is Loading) {
        if (passengerLastState.destination == null) {
          emit(UserErrorState('please provide destination'));
        } else if (passengerLastState.currentPosition.latitude ==
                invalidPosition.latitude &&
            passengerLastState.currentPosition.longitude ==
                invalidPosition.longitude) {
          emit(UserErrorState('Please Provide current Location'));
        }
      } else {}

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
        GetWalkDirections event, Emitter<MapUserState> emit) async {
      final permission = await Geolocator.requestPermission();
      final connectivity = await Connectivity().checkConnectivity();
      if (permission == LocationPermission.denied) {
        emit(UserErrorState('Please open location service'));
      } else if (connectivity == ConnectivityResult.none) {
        emit(UserErrorState('Check your internet Connection'));
      } else if (state is UserErrorState || state is PassengerState) {
        if (passengerLastState.destination == null) {
          emit(UserErrorState('Please Provide destination'));
        } else if (passengerLastState.currentPosition.latitude ==
                invalidPosition.latitude &&
            passengerLastState.currentPosition.longitude ==
                invalidPosition.longitude) {
          emit(UserErrorState('Please Provide current Location'));
        } else {
          try {
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
                        '${passengerLastState.currentPosition.latitude},${passengerLastState.currentPosition.longitude}',
                    destination:
                        '${passengerLastState.destination!.latitude},${passengerLastState.destination!.longitude}'),
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
            final newState = PassengerState(
                currentPosition: passengerLastState.currentPosition,
                lines: newLines,
                markers: passengerLastState.markers,
                controller: passengerLastState.controller,
                directions: steps,
                destination: passengerLastState.destination,
                destinationDescription:
                    passengerLastState.destinationDescription,
                currentLocationDescription:
                    passengerLastState.currentLocationDescription,
                passengerData: passengerLastState.passengerData);
            passengerLastState = newState;
            emit(newState);
          } catch (exception) {
            emit(UserErrorState('An Error has occured please try again'));
          }
        }
      } else {
        emit(UserErrorState('An Error has occured please try again'));
      }
    }

    on<GetWalkDirections>(getWalkDirections);

    FutureOr<void> getPassengerLocation(
        GoogleMapGetCurrentPosition event, Emitter<MapUserState> emit) async {
      emit(Loading('getting current Location'));
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
              currentLocationDescription:
                  currentState.currentLocationDescription,
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

    on<GoogleMapGetCurrentPosition>(getPassengerLocation);
  }
}

class UberDriverBloc extends Bloc<GoogleMapEvent, MapUserState> {
  UberDriverBloc() : super(uberLastState) {
    FutureOr<void> getDriverLocation(
        GoogleMapGetCurrentPosition event, Emitter<MapUserState> emit) async {
      emit(Loading('Getting current location'));
      MapUserState temp = await onGetCurrentPosition();

      if (temp is UserErrorState) {
        emit(UserErrorState(temp.message));
      } else if (temp is GoogleMapState) {
        try {
          await uberLastState.controller!.animateCamera(
              CameraUpdate.newCameraPosition(
                  CameraPosition(zoom: 150, target: temp.currentPosition)));
          final newState = UberDriverState(
              controller: uberLastState.controller,
              currentPosition: temp.currentPosition,
              lines: [],
              currentLocationDescription: temp.currentLocationDescription,
              destination: temp.destination,
              destinationDescription: temp.destinationDescription,
              markers: temp.markers,
              directions: [],
              driver: uberLastState.driver,
              passengerRequests: uberLastState.passengerRequests,
              userState: UserState.DRIVER);

          uberLastState = newState;
          emit(newState);
        } catch (exception) {
          emit(UserErrorState('An Error has occured please try again'));
        }
      }
    }

    on<GoogleMapGetCurrentPosition>(getDriverLocation);

    //   (event, emit) {
    //   final  permission = Geolocator.requestPermission();
    //   final connectivity = Connectivity().checkConnectivity();
    //   if (connectivity == ConnectivityResult.none) {
    //   return UserErrorState('Check your internet Connection');
    //   } else if (permission == LocationPermission.denied) {
    //     return UserErrorState('Please open location service');
    //   }
    //   else
    //   {
    //      state.controller!.moveCamera(CameraUpdate.newCameraPosition(
    //       CameraPosition(zoom: 50, target: event.destination)));
    //   Set<Marker> newMarkers = {
    //     ...state.markers,
    //     Marker(
    //         markerId: MarkerId('${event.destination}'),
    //         position: event.destination,
    //         icon: BitmapDescriptor.defaultMarkerWithHue(
    //             BitmapDescriptor.hueGreen)),
    //   };
    //   emit(UberDriverState(
    //       controller: state.controller,
    //       currentPosition: state.currentPosition,
    //       lines: [],
    //       currentLocationDescription: state.currentLocationDescription,
    //       destination: event.destination,
    //       destinationDescription: state.destinationDescription,
    //       markers: newMarkers,
    //       directions: [],
    //       passengerRequests: state.passengerRequests,
    //       driver: state.driver,
    //       userState: UserState.DRIVER));
    //     }
    // });

    on<GetPassengerRequests>((event, emit) async {
      final connectivity = await Connectivity().checkConnectivity();
      if (connectivity == ConnectivityResult.none) {
        emit(UserErrorState('check your Internet Connection'));
      } else if (state is UserErrorState || state is UberDriverState) {
        final newState = UberDriverState(
            controller: uberLastState.controller,
            currentPosition: uberLastState.currentPosition,
            lines: uberLastState.lines,
            currentLocationDescription:
                uberLastState.currentLocationDescription,
            destination: uberLastState.destination,
            destinationDescription: uberLastState.destinationDescription,
            markers: uberLastState.markers,
            directions: uberLastState.directions,
            passengerRequests: [...userRequests],
            driver: uberLastState.driver,
            userState: UserState.DRIVER);
        uberLastState = newState;
        emit(newState);
      }
    });
    on<AcceptPassengerRequest>((event, emit) async {
      final connectivity = await Connectivity().checkConnectivity();
      if (connectivity == ConnectivityResult.none) {
        emit(UserErrorState('check your Internet Connection'));
      } else if (state is UserErrorState || state is UberDriverState) {
        if (uberLastState.currentPosition.latitude ==
                invalidPosition.latitude &&
            uberLastState.currentPosition.longitude ==
                invalidPosition.longitude) {
          emit(UserErrorState('Please provide your current location'));
        } else {
          try {
            userRequests.removeWhere(
                (element) => element.id == event.passengerRequest.id);
            List<UserRequest> newList = [...userRequests];
            event.passengerRequest.driver = UberDriver(
                name: 'Mohamed',
                location: uberLastState.currentPosition,
                phone: '01010625272');
            acceptedRequest.add(event.passengerRequest);

            final newState = UberDriverState(
                controller: uberLastState.controller,
                currentPosition: uberLastState.currentPosition,
                lines: uberLastState.lines,
                currentLocationDescription:
                    uberLastState.currentLocationDescription,
                destination: uberLastState.destination,
                destinationDescription: uberLastState.destinationDescription,
                markers: uberLastState.markers,
                directions: uberLastState.directions,
                passengerRequests: newList,
                driver: uberLastState.driver,
                acceptedRequest: event.passengerRequest,
                userState: UserState.DRIVER);
            uberLastState = newState;
            emit(newState);
          } catch (exception) {
            emit(UserErrorState('An Error has occured'));
          }
        }
      }
    });
    on<RejectPassengerRequest>((event, emit) async {
      final connectivity = await Connectivity().checkConnectivity();
      if (connectivity == ConnectivityResult.none) {
        emit(UserErrorState('check your Internet Connection'));
      } else {
        try {
          userRequests.removeWhere(
              (element) => element.id == event.passengerRequest.id);
          List<UserRequest> newList = [...userRequests];
          event.passengerRequest.driver = null;

          event.passengerRequest.driver = uberLastState.driver;
          rejectedRequest.add(event.passengerRequest);
          final newState = UberDriverState(
              controller: uberLastState.controller,
              currentPosition: uberLastState.currentPosition,
              lines: uberLastState.lines,
              currentLocationDescription:
                  uberLastState.currentLocationDescription,
              destination: uberLastState.destination,
              destinationDescription: uberLastState.destinationDescription,
              markers: uberLastState.markers,
              directions: uberLastState.directions,
              passengerRequests: newList,
              driver: uberLastState.driver,
              acceptedRequest: null,
              userState: UserState.DRIVER);
          uberLastState = newState;
          emit(newState);
        } catch (exception) {
          emit(UserErrorState('An error has occured'));
        }
      }
    });
    on<GetPassengerDirections>((event, emit) async {
      final permission = await Geolocator.requestPermission();
      final connectivity = await Connectivity().checkConnectivity();
      if (connectivity == ConnectivityResult.none) {
        emit(UserErrorState('Check your internet Connection'));
      } else if (permission == LocationPermission.denied) {
        emit(UserErrorState('Please open location service'));
      } else {
        try {
          uberLastState.controller!.moveCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  zoom: 50,
                  target: uberLastState.acceptedRequest!.passengerLocation)));
          Set<Marker> newMarkers = {
            ...uberLastState.markers,
            Marker(
                markerId: MarkerId(
                    '${uberLastState.acceptedRequest!.passengerLocation}'),
                position: uberLastState.acceptedRequest!.passengerLocation,
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
                      '${uberLastState.currentPosition.latitude},${uberLastState.currentPosition.longitude}',
                  destination:
                      '${uberLastState.acceptedRequest!.passengerLocation.latitude},${uberLastState.acceptedRequest!.passengerLocation.longitude}'),
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
          final newState = UberDriverState(
              currentPosition: uberLastState.currentPosition,
              lines: newLines,
              markers: newMarkers,
              controller: uberLastState.controller,
              directions: steps,
              destination: uberLastState.acceptedRequest!.passengerLocation,
              destinationDescription:
                  uberLastState.acceptedRequest!.currentLocationDescription,
              currentLocationDescription:
                  uberLastState.currentLocationDescription,
              driver: uberLastState.driver,
              userState: UserState.DRIVER,
              acceptedRequest: uberLastState.acceptedRequest,
              passengerRequests: uberLastState.passengerRequests);
          uberLastState = newState;
          emit(newState);
        } catch (exception) {
          emit(UserErrorState('An error has occured'));
        }
      }
    });

    on<CancelTrip>((event, emit) async {
      final permission = await Geolocator.requestPermission();
      final connectivity = await Connectivity().checkConnectivity();
      if (connectivity == ConnectivityResult.none) {
        emit(UserErrorState('Check your internet Connection'));
      } else if (permission == LocationPermission.denied) {
        emit(UserErrorState('Please open location service'));
      } else {
        try {
          Set<Marker> newMarkers = {
            ...uberLastState.markers
                .where((element) => element.markerId.value == positionMarkerId)
          };
          event.passengerRequest.driver = null;
          userRequests.add(event.passengerRequest);
          event.passengerRequest.driver = uberLastState.driver;
          canceledTrips.add(event.passengerRequest);

          final newState = UberDriverState(
              currentPosition: uberLastState.currentPosition,
              lines: [],
              markers: newMarkers,
              controller: uberLastState.controller,
              directions: [],
              destination: null,
              destinationDescription: 'Unknown',
              currentLocationDescription: 'Unknown',
              driver: uberLastState.driver,
              userState: UserState.DRIVER,
              acceptedRequest: null,
              passengerRequests: uberLastState.passengerRequests);
          uberLastState = newState;
          emit(newState);
        } catch (exception) {
          emit(UserErrorState('an error has occured'));
        }
      }
    });
    on<StartTrip>((event, emit) async {
      final permission = await Geolocator.requestPermission();
      final connectivity = await Connectivity().checkConnectivity();
      if (connectivity == ConnectivityResult.none) {
        emit(UserErrorState('Check your internet Connection'));
      } else if (permission == LocationPermission.denied) {
        emit(UserErrorState('Please open location service'));
      } else {
        try {
          userRequests.removeWhere(
              (element) => element.id == event.passengerRequest.id);
          startedTrips.add(event.passengerRequest);

          final newState = UberDriverState(
              currentPosition: uberLastState.currentPosition,
              lines: uberLastState.lines,
              markers: uberLastState.markers,
              controller: uberLastState.controller,
              directions: uberLastState.directions,
              destination: uberLastState.destination,
              destinationDescription: uberLastState.destinationDescription,
              currentLocationDescription:
                  uberLastState.currentLocationDescription,
              driver: uberLastState.driver,
              userState: UserState.DRIVER,
              acceptedRequest: uberLastState.acceptedRequest,
              passengerRequests: userRequests);
          uberLastState = newState;
          emit(newState);
        } catch (exception) {
          emit(UserErrorState('an Error has occured'));
        }
      }
    });
    on<EndTrip>((event, emit) async {
      final permission = await Geolocator.requestPermission();
      final connectivity = await Connectivity().checkConnectivity();
      if (connectivity == ConnectivityResult.none) {
        emit(UserErrorState('Check your internet Connection'));
      } else if (permission == LocationPermission.denied) {
        emit(UserErrorState('Please open location service'));
      } else {
        try {
          endedTrips.add(event.passengerRequest);
          startedTrips.removeWhere(
              (element) => element.id == event.passengerRequest.id);
          final newState = UberDriverState(
              currentPosition: uberLastState.currentPosition,
              lines: [],
              markers: uberLastState.markers,
              controller: uberLastState.controller,
              directions: uberLastState.directions,
              destination: uberLastState.destination,
              destinationDescription: uberLastState.destinationDescription,
              currentLocationDescription:
                  uberLastState.currentLocationDescription,
              driver: uberLastState.driver,
              userState: UserState.DRIVER,
              acceptedRequest: null,
              passengerRequests: uberLastState.passengerRequests);
          uberLastState = newState;
          emit(newState);
        } catch (exception) {
          emit(UserErrorState('an Error has occured'));
        }
      }
    });
  }
}
