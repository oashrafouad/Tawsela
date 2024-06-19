// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRequest _$UserRequestFromJson(Map<String, dynamic> json) => UserRequest(
      Req_ID: json['req_id'] as int,
      Passenger_ID: json['passenger_id'] as int,
      Current_Location: json['current_location'] as String,
      Desired_Location: json['desired_location'] as String,
      Current_Location_Latitude: json['current_location_latitude'] as String,
      Current_Location_Longitude: json['current_location_longitude'] as String,
      Desired_Location_Latitude: json['desired_location_latitude'] as String,
      Desired_Location_Longitude: json['desired_location_longitude'] as String,
      is_reserved: json['is_reserved'] as bool,
    );

Map<String, dynamic> _$UserRequestToJson(UserRequest instance) =>
    <String, dynamic>{
      'Req_ID': instance.Req_ID,
      'Passenger_ID': instance.Passenger_ID,
      'Current_Location': instance.Current_Location,
      'Desired_Location': instance.Desired_Location,
      'Current_Location_Latitude': instance.Current_Location_Latitude,
      'Current_Location_Longitude': instance.Current_Location_Longitude,
      'Desired_Location_Latitude': instance.Desired_Location_Latitude,
      'Desired_Location_Longitude': instance.Desired_Location_Longitude,
      'is_reserved': instance.is_reserved,
    };
