import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_bloc.dart';
import 'package:tawsela_app/models/data_base.dart';
import 'package:tawsela_app/models/data_models/request_model.dart';

class UberCoice extends StatelessWidget {
  const UberCoice({super.key});

  @override
  Widget build(BuildContext context) {
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
              userRequests.add(UserRequest(
                id: Random().nextInt(100),
                passengerName: 'Ahmed Ibrahim Ali',
                phone: '01558440191',
                passengerLocation:
                    BlocProvider.of<PassengerBloc>(context).state.destination!,
                passengerDestination: BlocProvider.of<PassengerBloc>(context)
                    .state
                    .currentPosition,
                destinationDescription: BlocProvider.of<PassengerBloc>(context)
                    .state
                    .currentLocationDescription,
                currentLocationDescription:
                    BlocProvider.of<PassengerBloc>(context)
                        .state
                        .destinationDescription,
              ));
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
                    "Search for a driver",
                    style: TextStyle(color: Colors.white),
                  )
                ]),
          ),
        ),
      ),
    ));
  }
}
