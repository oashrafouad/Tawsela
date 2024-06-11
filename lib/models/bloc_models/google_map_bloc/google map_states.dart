import 'package:google_directions_api/google_directions_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_place_holder.dart';

import 'package:tawsela_app/models/data_models/user_states.dart';

class MapUserState {
  const MapUserState();
  // @override
  // List<Object?> get props => [identityHashCode(this)];
}

class UserErrorState extends MapUserState {
  final String message;
  const UserErrorState(this.message);

  get destination => null;
  // @override
  // List<Object> get props => [message];
}

class Loading extends MapUserState {
  final message;
  const Loading(this.message);
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

  // @override
  // List<Object?> get props =>
  //     [currentPosition, lines, markers, directions, destination, userState];
}

enum ErrorStates {
  NO_INTERNET_CONNECTION,
  MUST_PROVIDE_CURRENT_LOCATION,
  CAN_NOT_ACCEPT_MORE_THAN_ONE_REQUEST
}


  // @override
  // List<Object?> get props => [
  //       currentPosition,
  //       lines,
  //       markers,
  //       directions,
  //       destination,
  //       userState,
  //       driver,
  //       passengerRequests,
  //       acceptedRequest
  //     ];



