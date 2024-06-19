// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trip _$TripFromJson(Map<String, dynamic> json) => Trip(
      Driver_ID: json['driver_id'] as String,
      Start_Time: json['start_time'] as String,
      End_Time: json['end_time'] as String,
      Trip_Status: json['trip_status'] as String,
      Price: json['price'] as String,
      Trip_type: json['trip_type'] as String,
      Current_Location: json['current_location'] as String,
      Desired_Location: json['desired_location'] as String,
      Current_Location_Latitude: json['current_location_latitude'] as String,
      Current_Location_Longitude: json['current_location_longitude'] as String,
      Desired_Location_Latitude: json['desired_location_latitude'] as String,
      Desired_Location_Longitude: json['desired_location_longitude'] as String,
    );

Map<String, dynamic> _$TripToJson(Trip instance) => <String, dynamic>{
      'Driver_ID': instance.Driver_ID,
      'Start_Time': instance.Start_Time,
      'End_Time': instance.End_Time,
      'Trip_Status': instance.Trip_Status,
      'Price': instance.Price,
      'Trip_type': instance.Trip_type,
      'Current_Location': instance.Current_Location,
      'Desired_Location': instance.Desired_Location,
      'Current_Location_Latitude': instance.Current_Location_Latitude,
      'Current_Location_Longitude': instance.Current_Location_Longitude,
      'Desired_Location_Latitude': instance.Desired_Location_Latitude,
      'Desired_Location_Longitude': instance.Desired_Location_Longitude,
    };
