import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tawsela_app/models/data_models/uber_driver.dart';

class UserRequest {
  final int id;
  final String passengerName;
  final String phone;
  final LatLng passengerLocation;
  final LatLng passengerDestination;
  final String destinationDescription;
  final String currentLocationDescription;
  UberDriver? driver;
  UserRequest(
      {this.driver,
      required this.id,
      required this.passengerName,
      required this.phone,
      required this.passengerLocation,
      required this.passengerDestination,
      required this.destinationDescription,
      required this.currentLocationDescription});
}
