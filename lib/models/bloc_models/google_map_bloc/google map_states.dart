import 'package:equatable/equatable.dart';
import 'package:google_directions_api/google_directions_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tawsela_app/models/data_models/path_model/path.dart';
import 'package:tawsela_app/models/data_models/request_model.dart';
import 'package:tawsela_app/models/data_models/user_data.dart';
import 'package:tawsela_app/models/data_models/user_states.dart';

class NeverEqualState extends Equatable {
  const NeverEqualState();
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class MapUserState extends NeverEqualState {
  @override
  List<Object?> get props => [identityHashCode(this)];
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
    this.currentPosition = const LatLng(0, 0),
    this.destination = const LatLng(0, 0),
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

class UberDriverErrorState extends MapUserState {
  final String message;
  UberDriverErrorState(this.message);
  @override
  List<Object?> get props => [message];
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

class PassengerErrorState extends MapUserState {
  final String message;
  PassengerErrorState(this.message);
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
