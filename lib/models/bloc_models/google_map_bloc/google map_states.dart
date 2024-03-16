import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_directions_api/google_directions_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tawsela_app/models/data_models/location_model/location.dart';
import 'package:tawsela_app/models/data_models/path_model/path.dart';

class NeverEqualState extends Equatable {
  const NeverEqualState();
  @override
  List<Object> get props => [identityHashCode(this)];
}

class GoogleMapState extends NeverEqualState {
  final GoogleMapController? controller;
  final LatLng currentPosition;
  final List<Polyline> lines;
  final Set<Marker> markers;
  final Path_t pathData;

  const GoogleMapState(this.currentPosition, this.lines, this.markers,
      this.pathData, this.controller);

  @override
  List<Object> get props => [currentPosition, lines, markers, pathData];
}
