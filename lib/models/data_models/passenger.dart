import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tawsela_app/models/data_models/user_data.dart';

class Passenger extends UserData {
  Passenger(
      {required String firstName,
      required String lastName,
      required LatLng location,
      required String phone,
       int? age,
       String? email})
      : super(
            firstName: firstName,
            location: location,
            lastName: lastName,
            age: age,
            email: email,
            phone: phone);
}
