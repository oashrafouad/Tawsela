import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tawsela_app/models/bloc_models/driver_map_bloc/driver_map_bloc.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google%20map_states.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_bloc.dart';

class DriverGoogleMapWidget extends StatelessWidget {
  final bool isTripStarted;
  const DriverGoogleMapWidget({required this.isTripStarted, super.key});

  @override
  Widget build(BuildContext context) {
    late UberDriverState uberDriverProvider;
    if (BlocProvider.of<UberDriverBloc>(context).state is UserErrorState) {
      uberDriverProvider = uberLastState;
    } else {
      uberDriverProvider =
          BlocProvider.of<UberDriverBloc>(context).state as UberDriverState;
    }
    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        height: (uberDriverProvider.destination != null)
            ? constraints.maxHeight * 1
            : constraints.maxHeight,
        child: (isTripStarted)
            ? StreamBuilder<Position>(
                stream: Geolocator.getPositionStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData == true) {
                    return GoogleMap(
                        onMapCreated: (GoogleMapController controller) {
                          uberDriverProvider.controller = controller;
                        },
                        markers: {
                          ...uberDriverProvider.markers,
                          Marker(
                              markerId: MarkerId('my-pos'),
                              position: LatLng(snapshot.data!.latitude,
                                  snapshot.data!.longitude),
                              icon: BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueYellow))
                        },
                        polylines: (uberDriverProvider.lines.isNotEmpty)
                            ? {...uberDriverProvider.lines}
                            : {},
                        initialCameraPosition: CameraPosition(
                            target: LatLng(snapshot.data!.latitude,
                                snapshot.data!.longitude)));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                })
            : GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  uberDriverProvider.controller = controller;
                },
                markers: uberDriverProvider.markers,
                polylines: (uberDriverProvider.lines.isNotEmpty)
                    ? {...uberDriverProvider.lines}
                    : {},
                initialCameraPosition:
                    CameraPosition(target: uberDriverProvider.currentPosition)),
      ),
    );
  }
}
