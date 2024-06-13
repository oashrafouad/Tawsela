import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Trip {
  final String Trip_ID;
  final String Trip_Status;
  final String Passenger_Phone;
  final String Driver_Phone;
  final String comment;
  final String Current_Location;
  final String Desired_Location;
  final String currentLocationDescription;
  final String desiredDestinationDescription;
  const Trip({
    required this.Trip_ID,
    required this.Trip_Status,
    required this.Passenger_Phone,
    required this.Driver_Phone,
    this.comment = '',
    required this.Current_Location,
    required this.Desired_Location,
    required this.currentLocationDescription,
    required this.desiredDestinationDescription,
  });
}
