import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google%20map_states.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_bloc.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_events.dart';
import 'package:tawsela_app/models/data_models/location_model/location.dart';
import 'package:another_flushbar/flushbar.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  List<Location_t> locations = [];
  LatLng currentLocation = LatLng(29, 32);
  late Future<String> points;
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocConsumer<GoogleMapBloc, GoogleMapState>(
      listener: (context, state) {
        Flushbar(
          borderRadius: BorderRadius.circular(5),
          message: 'State has changed',
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
          dismissDirection: FlushbarDismissDirection.VERTICAL,
          flushbarPosition: FlushbarPosition.TOP,
        ).show(context);
      },
      builder: (context, state) {
        return Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                  child: Icon(Icons.gps_fixed),
                  onPressed: () => BlocProvider.of<GoogleMapBloc>(context)
                      .add(GoogleMapGetCurrentPosition())),
              FloatingActionButton(
                  child: Icon(Icons.line_axis),
                  onPressed: () => BlocProvider.of<GoogleMapBloc>(context)
                      .add(GoogleMapline())),
              FloatingActionButton(
                  child: Icon(Icons.calculate),
                  onPressed: () => BlocProvider.of<GoogleMapBloc>(context)
                      .add(GoogleMapGetPath()))
            ],
          ),
          body: GoogleMap(
              markers: <Marker>{
                if (state.currentPosition.latitude != 0.0 &&
                    state.currentPosition.longitude != 0.0)
                  Marker(
                    markerId: MarkerId('my-position'),
                    position: (state.currentPosition),
                    icon: BitmapDescriptor.defaultMarker,
                  )
              },
              polylines: (state.lines.length >= 1) ? {...state.lines} : {},
              initialCameraPosition:
                  CameraPosition(target: state.currentPosition)),
        );
      },
    );
  }
}
