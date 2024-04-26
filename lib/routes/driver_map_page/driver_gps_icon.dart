import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawsela_app/models/bloc_models/driver_map_bloc/driver_map_bloc.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google%20map_states.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_bloc.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_events.dart';

class DriverGpsIcon extends StatelessWidget {
  const DriverGpsIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        style: IconButton.styleFrom(backgroundColor: Colors.green),
        onPressed: () {
          BlocProvider.of<UberDriverBloc>(context)
              .add(GoogleMapGetCurrentPosition());
        },
        icon: const Icon(
          Icons.gps_fixed,
          color: Colors.white,
        ));
  }
}
