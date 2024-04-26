import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:google_directions_api/google_directions_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_bloc.dart';
import 'package:tawsela_app/models/data_models/path_model/path.dart';
import 'package:tawsela_app/models/data_models/request_model.dart';
import 'package:tawsela_app/models/data_models/user_data.dart';
import 'package:tawsela_app/models/data_models/user_states.dart';

class MapUserState extends Equatable {
  const MapUserState();
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class UserErrorState extends MapUserState {
  final String message;
  const UserErrorState(this.message);
  @override
  List<Object> get props => [message];
}

class GoogleMapState extends MapUserState {
  GoogleMapController? controller;
  final UserState userState;
  final String currentLocationDescription;
  final String destinationDescription;
  final LatLng currentPosition;
  final LatLng? destination;
  final List<Polyline> lines;
  final Set<Marker> markers;

  final List<Step> directions;

  GoogleMapState({
    this.currentPosition = invalidPosition,
    this.destination = null,
    this.lines = const [],
    this.markers = const {},
    this.controller,
    this.directions = const [],
    this.userState = UserState.PASSENGER,
    this.currentLocationDescription = 'Unknown',
    this.destinationDescription = 'Unknown',
  });

  @override
  List<Object?> get props =>
      [currentPosition, lines, markers, directions, destination, userState];
}

enum ErrorStates {
  NO_INTERNET_CONNECTION,
  MUST_PROVIDE_CURRENT_LOCATION,
  CAN_NOT_ACCEPT_MORE_THAN_ONE_REQUEST
}

class UberDriverState extends GoogleMapState {
  final UberDriver? driver;
  final List<UserRequest> passengerRequests;
  final UserRequest? acceptedRequest;
  UberDriverState(
      {required GoogleMapController? controller,
      required UserState userState,
      required LatLng currentPosition,
      LatLng? destination,
      String currentLocationDescription = 'Unknown',
      String destinationDescription = 'Unknown',
      required List<Polyline> lines,
      required Set<Marker> markers,
      required List<Step> directions,
      required this.driver,
      this.passengerRequests = const [],
      this.acceptedRequest})
      : super(
          controller: controller,
          currentPosition: currentPosition,
          lines: lines,
          markers: markers,
          directions: directions,
          destination: destination,
          userState: UserState.DRIVER,
          currentLocationDescription: currentLocationDescription,
          destinationDescription: destinationDescription,
        );
  @override
  List<Object?> get props => [
        currentPosition,
        lines,
        markers,
        directions,
        destination,
        userState,
        driver,
        passengerRequests,
        acceptedRequest
      ];
}

class PassengerState extends GoogleMapState {
  final Passenger passengerData;
  PassengerState({
    required GoogleMapController? controller,
    required LatLng currentPosition,
    LatLng? destination,
    String currentLocationDescription = 'Unknown',
    String destinationDescription = 'Unknown',
    required List<Polyline> lines,
    required Set<Marker> markers,
    required List<Step> directions,
    required this.passengerData,
  }) : super(
            controller: controller,
            currentPosition: currentPosition,
            lines: lines,
            markers: markers,
            directions: directions,
            destination: destination,
            currentLocationDescription: currentLocationDescription,
            destinationDescription: destinationDescription,
            userState: UserState.DRIVER);
  @override
  List<Object?> get props => [
        currentPosition,
        lines,
        markers,
        directions,
        destination,
        userState,
        passengerData
      ];
}
