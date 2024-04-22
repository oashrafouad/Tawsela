import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawsela_app/models/bloc_models/driver_map_bloc/driver_map_bloc.dart';
import 'package:tawsela_app/models/bloc_models/driver_map_bloc/driver_map_events.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_bloc.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_events.dart';

class UserInformation extends StatelessWidget {
  bool showDirection;
  UserInformation([this.showDirection = false]);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final driverMapProvider = BlocProvider.of<DriverMapBloc>(context);
    final uberDriverProvider = BlocProvider.of<UberDriverBloc>(context);
    return Column(
      children: [
        Column(
          children: [
            Card(
              shadowColor: Colors.green,
              elevation: 4,
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      child: Icon(Icons.person),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                        '${uberDriverProvider.state.acceptedRequest!.passengerName}')
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 2,
                                ),
                                Card(
                                  shadowColor: Colors.green,
                                  color: Colors.white,
                                  surfaceTintColor: Colors.white,
                                  elevation: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          fit: FlexFit.loose,
                                          child: Text(
                                              '${uberDriverProvider.state.acceptedRequest!.destinationDescription}'),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ]),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green),
                              onPressed: () {},
                              child: Row(children: [
                                Icon(
                                  Icons.call,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Call',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ])),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              onPressed: () {
                                uberDriverProvider.add(CancelTrip(
                                    passengerRequest: uberDriverProvider
                                        .state.acceptedRequest!));
                                uberDriverProvider.add(GetPassengerRequests());
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.cancel,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if (showDirection == true)
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue),
                            onPressed: () {
                              driverMapProvider.add(HideTopSheet());
                              Future.delayed(Duration(seconds: 2));
                              uberDriverProvider.add(GetPassengerDirections());
                              driverMapProvider.add(ShowBottomSheet());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.directions,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Directions',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
