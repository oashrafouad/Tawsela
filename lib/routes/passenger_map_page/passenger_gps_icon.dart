import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google%20map_states.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_bloc.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_events.dart';

class PassengerGpsIcon extends StatelessWidget {
  const PassengerGpsIcon({super.key});

  @override
  Widget build(BuildContext context) {
    late PassengerState googleMapProvider;
    if (BlocProvider.of<PassengerBloc>(context).state is UserErrorState) {
      googleMapProvider = passengerLastState;
    } else {
      googleMapProvider =
          BlocProvider.of<PassengerBloc>(context).state as PassengerState;
    }
    return IconButton(
        style: IconButton.styleFrom(backgroundColor: Colors.white),
        onPressed: () {
          BlocProvider.of<PassengerBloc>(context)
              .add(GoogleMapGetCurrentPosition());
        },
        icon: const Icon(
          Icons.gps_fixed,
          color: Colors.green,
        ));
  }
}
