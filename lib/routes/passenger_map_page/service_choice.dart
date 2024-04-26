import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google%20map_states.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_bloc.dart';

class ServiceChoice extends StatelessWidget {
  const ServiceChoice({super.key});

  @override
  Widget build(BuildContext context) {
    late PassengerState passengerState;
    if (BlocProvider.of<PassengerBloc>(context).state is UserErrorState) {
      passengerState = passengerLastState;
    } else {
      passengerState =
          BlocProvider.of<PassengerBloc>(context).state as PassengerState;
    }
    return Container();
  }
}
