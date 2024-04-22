import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google%20map_states.dart';

class UserData {
  final String name;
  final LatLng location;
  final String phone;
  const UserData({
    required this.name,
    required this.location,
    required this.phone,
  });
}

class Passenger extends UserData {
  Passenger({
    required String name,
    required LatLng location,
    required String phone,
  }) : super(name: name, location: location, phone: phone);
}

class UberDriver extends UserData {
  UberDriver({
    required String name,
    required LatLng location,
    required String phone,
  }) : super(name: name, location: location, phone: phone);
}
