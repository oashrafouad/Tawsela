import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tawsela_app/models/data_models/user_request_model/request_model.dart';
part 'trip.g.dart';

@JsonSerializable()
class Trip {
  final String? Driver_ID;
  final String? Start_Time;
  final String? End_Time;
  final String? Trip_Status;
  final String? Price;
  final String? Trip_type;
  final String? Current_Location;
  final String? Desired_Location;
  final String? Current_Location_Latitude;
  final String? Current_Location_Longitude;
  final String? Desired_Location_Latitude;
  final String? Desired_Location_Longitude;
  const Trip({
    required this.Driver_ID,
    required this.Start_Time,
    required this.End_Time,
    required this.Trip_Status,
    required this.Price,
    required this.Trip_type,
    required this.Current_Location,
    required this.Desired_Location,
    required this.Current_Location_Latitude,
    required this.Current_Location_Longitude,
    required this.Desired_Location_Latitude,
    required this.Desired_Location_Longitude,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return _$TripFromJson(json);
  }
  Map<String, dynamic> toJson() {
    return _$TripToJson(this);
  }
}
