import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google%20map_states.dart';
import 'package:tawsela_app/models/data_models/location_model/location.dart';
import 'package:tawsela_app/models/data_models/path_model/path.dart';
import 'package:google_directions_api/google_directions_api.dart';

abstract class GoogleMapEvent extends Equatable {
  const GoogleMapEvent();
  @override
  List<Object> get props => [];
}

class GoogleMapGetCurrentPosition extends GoogleMapEvent {
  const GoogleMapGetCurrentPosition();
}

class GoogleMapGetPath extends GoogleMapEvent {
  const GoogleMapGetPath();
}

class GoogleMapline extends GoogleMapEvent {
  const GoogleMapline();
}
