import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google%20map_states.dart';
import 'package:tawsela_app/models/data_base.dart';
import 'package:tawsela_app/models/data_models/user_request_model/request_model.dart';
import 'package:tawsela_app/models/passenger_bloc/passenger_bloc.dart';
import 'package:tawsela_app/models/passenger_bloc/passenger_events.dart';
import 'package:tawsela_app/models/passenger_bloc/passenger_states.dart';

class UberCoice extends StatelessWidget {
  const UberCoice({super.key});

  @override
  Widget build(BuildContext context) {
    late PassengerState currentState;
    final state = BlocProvider.of<PassengerBloc>(context).state;
    if (state is UserErrorState) {
      currentState = passengerLastState;
    } else if (state is Loading) {
      return Column(
        children: [
          CircularProgressIndicator(
            backgroundColor: Colors.green,
          ),
          Text(state.message)
        ],
      );
    } else {
      currentState = state as PassengerState;
    }
    return Center(
        child: LayoutBuilder(
      builder: (context, constraints) => Container(
        padding: const EdgeInsets.only(top: 50),
        width: constraints.maxWidth * 0.7,
        child: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.all(20)),
            onPressed: () {
              BlocProvider.of<PassengerBloc>(context).add(RequestUberDriver(
                  passengerRequest: UserRequest(
                Req_ID: DateTime.now().toString() +
                    passengerLastState.passengerData.phone,
                Current_Location: passengerLastState.currentLocationDescription,
                Desired_Location: passengerLastState.destinationDescription,
                Current_Location_Latitude:
                    passengerLastState.currentPosition.latitude.toString(),
                Current_Location_Longitude:
                    passengerLastState.currentPosition.longitude.toString(),
                Desired_Location_Latitude:
                    passengerLastState.destination!.latitude.toString(),
                Desired_Location_Longitude:
                    passengerLastState.destination!.longitude.toString(),
                Passenger_ID: passengerLastState.passengerData.phone,
                is_reserved: false,
              )));
            },
            child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.car_crash_sharp,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Search for a driver',
                    style: TextStyle(color: Colors.white),
                  )
                ]),
          ),
        ),
      ),
    ));
  }
}
