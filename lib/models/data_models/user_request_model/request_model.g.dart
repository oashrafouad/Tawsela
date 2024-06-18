// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRequest _$UserRequestFromJson(Map<String, dynamic> json) => UserRequest(
      Req_ID: json['Req_ID'] as String,
      Passenger_ID: json['Passenger_ID'] as String,
      Current_Location: json['Current_Location'] as String,
      Desired_Location: json['Desired_Location'] as String,
      Current_Location_Latitude: json['Current_Location_Latitude'] as String,
      Current_Location_Longitude: json['Current_Location_Longitude'] as String,
      Desired_Location_Latitude: json['Desired_Location_Latitude'] as String,
      Desired_Location_Longitude: json['Desired_Location_Longitude'] as String,
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
