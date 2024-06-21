import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google%20map_states.dart';
import 'package:tawsela_app/models/bloc_models/passenger_bloc/passenger_bloc.dart';
import 'package:tawsela_app/models/bloc_models/passenger_bloc/passenger_events.dart';
import 'package:tawsela_app/models/bloc_models/passenger_bloc/passenger_states.dart';
import 'package:tawsela_app/models/data_models/user_request_model/request_model.dart';
import 'package:tawsela_app/view/screens/driver_map_page/user_information.dart';
import 'package:tawsela_app/view/screens/passenger_map_page/driver_info.dart';

class UberCoice extends StatelessWidget {
  static const String id = 'uber_choice';

  const UberCoice({super.key});

  @override
  Widget build(BuildContext context) {
    late PassengerState currentState;
    if (BlocProvider.of<PassengerBloc>(context).state is UserErrorState) {
      currentState = passengerLastState;
    } else if (BlocProvider.of<PassengerBloc>(context).state is Loading) {
      final state = BlocProvider.of<PassengerBloc>(context).state as Loading;
      return Column(
        children: [
          CircularProgressIndicator(
            color: Colors.green,
          ),
          Text(state.message.toString())
        ],
      );
    } else {
      currentState =
          BlocProvider.of<PassengerBloc>(context).state as PassengerState;
    }
    return (passengerLastState.driverData != null)
        ? DriverInfo()
        : Center(
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
                    BlocProvider.of<PassengerBloc>(context).add(
                        RequestUberDriver(
                            passengerRequest: UserRequest(
                                f_name:
                                    passengerLastState.passengerData.firstName,
                                l_name:
                                    passengerLastState.passengerData.lastName,
                                phone_num:
                                    passengerLastState.passengerData.phone,
                                Current_Location: passengerLastState
                                    .currentLocationDescription,
                                Desired_Location:
                                    passengerLastState.destinationDescription,
                                Current_Location_Latitude: passengerLastState
                                    .currentPosition.latitude
                                    .toString(),
                                Current_Location_Longitude: passengerLastState
                                    .currentPosition.longitude
                                    .toString(),
                                Desired_Location_Latitude: passengerLastState
                                    .currentPosition.latitude
                                    .toString(),
                                Desired_Location_Longitude: passengerLastState
                                    .currentPosition.longitude
                                    .toString(),
                                Req_ID: '414141',
                                is_reserved: 'false')));
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
