import 'dart:async';

// import 'package:dio/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_directions_api/google_directions_api.dart' hide Distance;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google%20map_states.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_events.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_place_holder.dart';
import 'package:tawsela_app/models/bloc_models/uber_driver_bloc/uber_driver_events.dart';
import 'package:tawsela_app/models/bloc_models/uber_driver_bloc/uber_driver_states.dart';
import 'package:tawsela_app/models/data_models/trip_model/trip.dart';
import 'package:tawsela_app/models/data_models/user_request_model/request_model.dart';
import 'package:tawsela_app/models/data_models/uber_driver.dart';
import 'package:tawsela_app/models/data_models/user_states.dart';
import 'package:connectivity/connectivity.dart';
import 'package:tawsela_app/models/get_it.dart/key_chain.dart';
import 'package:tawsela_app/models/servers/google_server.dart';
import 'package:tawsela_app/models/servers/main_server.dart';
// import 'package:plugin_wifi_connect/plugin_wifi_connect.dart';

const gettingCurrentLocationPlaceHolder = 'Getting Current Location';
UberDriverState uberLastState = UberDriverState(
    controller: null,
    userState: UserState.DRIVER,
    currentPosition: LatLng(-1, -1),
    lines: [],
    markers: {},
    directions: [],
    driver: UberDriver(
        lastName: 'last name',
        age: 18,
        email: 'email',
        rating: 9,
        firstName: 'name',
        location: invalidPosition,
        phone: '67363653'));
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
    // } else if (PluginWifiConnect.isEnabled == false) {
    //   return (UserErrorState('Please open wifi'));
    // }
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
      print(exception.toString());
      return UserErrorState('An Error has occured please try again');
    }
  }
}

class UberDriverBloc extends Bloc<GoogleMapEvent, MapUserState> {
  UberDriverBloc() : super(uberLastState) {
    FutureOr<void> getDriverLocation(
        GoogleMapGetCurrentPosition event, Emitter<MapUserState> emit) async {
      emit(Loading(gettingCurrentLocationPlaceHolder));
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
        List<UserRequest> userRequests = [];
        try {
          userRequests = await MainServer.getAllRequests();
        } catch (error) {
          emit(UserErrorState(error.toString()));
        }
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
            passengerRequests: userRequests,
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
            // checkking user request if it is reserved or not
            UserRequest? request;
            try {
              request = await MainServer.getRequestById(
                  userRequestId: event.passengerRequest.Req_ID!);
            } catch (error) {
              print(error);
            }
            print(request?.toJson());
            String? isValid = request?.is_reserved;
            if (isValid == 'true') {
              emit(UserErrorState('Another driver has accepted the trip'));
            } else {
              await MainServer.acceptRequest(
                  request_id: request!.Req_ID!,
                  Phone_Num: uberLastState.driver!.phone);

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
                  passengerRequests: uberLastState.passengerRequests,
                  driver: uberLastState.driver,
                  acceptedRequest: event.passengerRequest,
                  userState: UserState.DRIVER);
              uberLastState = newState;
              emit(newState);
            }
          } catch (exception) {
            emit(UserErrorState(exception.toString()));
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
          uberLastState.passengerRequests.removeWhere(
              (element) => element.Req_ID == event.passengerRequest.Req_ID);

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
              passengerRequests: uberLastState.passengerRequests,
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
          final LatLng target_location = LatLng(
            // Latitude value
            double.parse(
                uberLastState.acceptedRequest!.Current_Location_Latitude!),
            // Longitude Value
            double.parse(
                uberLastState.acceptedRequest!.Current_Location_Longitude!),
          );
          uberLastState.controller!.moveCamera(CameraUpdate.newCameraPosition(
              CameraPosition(zoom: 50, target: target_location)));
          Set<Marker> newMarkers = {
            ...uberLastState.markers,
            Marker(
                markerId: MarkerId(
                    '${uberLastState.acceptedRequest!.Current_Location}'),
                position: target_location,
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen)),
          };

          DirectionsService.init(KeyChain.chain.get<GoogleServer>().url);
          DirectionsService directions = DirectionsService();
          Polyline path = Polyline(
              polylineId: PolylineId('path'), color: Colors.green, points: []);
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
                      '${target_location.latitude},${target_location.longitude}'),
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
              destination: target_location,
              destinationDescription:
                  uberLastState.acceptedRequest!.Current_Location!,
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
          MainServer.createTrip(
              trip: Trip(
                  Driver_ID: uberLastState.driver!.phone,
                  Start_Time: DateTime.now().toString(),
                  End_Time: DateTime.now().toString(),
                  Trip_Status: 'Uber',
                  Price: '200 LE',
                  Trip_type: 'accepted',
                  Current_Location:
                      uberLastState.acceptedRequest!.Current_Location,
                  Desired_Location:
                      uberLastState.acceptedRequest!.Desired_Location,
                  Current_Location_Latitude:
                      uberLastState.acceptedRequest!.Current_Location_Latitude,
                  Current_Location_Longitude:
                      uberLastState.acceptedRequest!.Current_Location_Longitude,
                  Desired_Location_Latitude:
                      uberLastState.acceptedRequest!.Desired_Location_Latitude,
                  Desired_Location_Longitude: uberLastState
                      .acceptedRequest!.Desired_Location_Longitude));

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
              passengerRequests: uberLastState.passengerRequests);
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
