import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tawsela_app/models/data_models/request_model.dart';
import 'package:tawsela_app/models/data_models/user_data.dart';
import 'package:tawsela_app/models/data_models/user_states.dart';

abstract class GoogleMapEvent extends Equatable {
  const GoogleMapEvent();
  @override
  List<Object> get props => [];
}

// ************************* User Events *******************
class GoogleMapGetCurrentPosition extends GoogleMapEvent {
  const GoogleMapGetCurrentPosition();
}

class SwitchMode extends GoogleMapEvent {
  final UserState userState;
  const SwitchMode({required this.userState});
}

// *********************** Passenger Events *****************
abstract class PassengerEvent extends GoogleMapEvent {
  const PassengerEvent();
}

class GetNearestPathToServiceLine extends PassengerEvent {
  const GetNearestPathToServiceLine();
}

class RequestUberDriver extends PassengerEvent {
  final UserRequest passengerRequest;
  const RequestUberDriver({required this.passengerRequest});
}

class GetWalkDirections extends PassengerEvent {
  final LatLng passengerDestination;
  const GetWalkDirections({required this.passengerDestination});
}

class GetDestination extends PassengerEvent {
  final LatLng destination;
  final String destinationDescription;
  const GetDestination(
      {required this.destination, required this.destinationDescription});
}

// ************** Driver Events *************************//
abstract class DriverEvent extends GoogleMapEvent {
  const DriverEvent();
}

class GetPassengerRequests extends DriverEvent {
  const GetPassengerRequests();
}

class AcceptPassengerRequest extends DriverEvent {
  final UserRequest passengerRequest;
  const AcceptPassengerRequest({required this.passengerRequest});
}

class RejectPassengerRequest extends DriverEvent {
  final UserRequest passengerRequest;
  const RejectPassengerRequest({required this.passengerRequest});
}

class CallPassenger extends DriverEvent {
  const CallPassenger();
}

class CancelTrip extends DriverEvent {
  final UserRequest passengerRequest;
  const CancelTrip({required this.passengerRequest});
}

class StartTrip extends DriverEvent {
  final UserRequest passengerRequest;
  const StartTrip({required this.passengerRequest});
}

class EndTrip extends DriverEvent {
  final UserRequest passengerRequest;
  const EndTrip({required this.passengerRequest});
}

class GetPassengerDirections extends DriverEvent {
  const GetPassengerDirections();
}
