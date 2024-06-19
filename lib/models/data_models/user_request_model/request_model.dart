import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tawsela_app/models/data_models/uber_driver.dart';
import 'package:json_annotation/json_annotation.dart';
part 'request_model.g.dart';

@JsonSerializable()
class UserRequest {
  final int Req_ID;
  final int Passenger_ID;
  final String Current_Location;
  final String Desired_Location;
  final String Current_Location_Latitude;
  final String Current_Location_Longitude;
  final String Desired_Location_Latitude;
  final String Desired_Location_Longitude;
  final bool is_reserved;
  const UserRequest({
    required this.Req_ID,
    required this.Passenger_ID,
    required this.Current_Location,
    required this.Desired_Location,
    required this.Current_Location_Latitude,
    required this.Current_Location_Longitude,
    required this.Desired_Location_Latitude,
    required this.Desired_Location_Longitude,
    required this.is_reserved,
  });

  factory UserRequest.fromJson(Map<String, dynamic> json) {
    return _$UserRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserRequestToJson(this);
  }
}
