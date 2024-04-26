import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:location/location.dart';

import 'package:tawsela_app/models/bloc_models/driver_map_bloc/driver_map_bloc.dart';
import 'package:tawsela_app/models/bloc_models/driver_map_bloc/driver_map_states.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google%20map_states.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_bloc.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_events.dart';
import 'package:tawsela_app/models/bloc_models/user_preferences/user_preference_bloc.dart';
import 'package:tawsela_app/models/bloc_models/user_preferences/user_preference_events.dart';

import 'package:tawsela_app/routes/driver_map_page/driver_draggable_sheet.dart';
import 'package:tawsela_app/routes/driver_map_page/driver_gps_icon.dart';
import 'package:tawsela_app/routes/driver_map_page/driver_map_switch.dart';
import 'package:tawsela_app/routes/driver_map_page/driver_google_map_widget.dart';
import 'package:tawsela_app/routes/driver_map_page/user_information.dart';
import 'package:tawsela_app/routes/driver_map_page/user_request_view.dart';

class DriverPage extends StatefulWidget {
  const DriverPage({super.key});
  @override
  State<DriverPage> createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  List<String> tripStates = ['Start Trip', 'End Trip'];
  bool isTripStarted = false;
  // late Future<Position> currentLocationGetter;
  // late Location location;
  // late Position pos;
  // LocationData? currentLocation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // location = Location();
    // currentLocationGetter = Geolocator.getCurrentPosition();
    // location.onLocationChanged.listen((newLocation) {
    //   currentLocation = newLocation;
    // });
  }

  @override
  Widget build(BuildContext context) {
    final driverMapProvider = BlocProvider.of<DriverMapBloc>(context);
    late UberDriverState uberDriverProvider;
    return BlocConsumer<UberDriverBloc, MapUserState>(
      listener: (context, state) {
        if (state is UserErrorState) {
          Flushbar(
            message: state.message,
            backgroundColor: Colors.red,
            messageColor: Colors.white,
            flushbarPosition: FlushbarPosition.BOTTOM,
            duration: Duration(seconds: 1),
          ).show(context);
        } else {
          Flushbar(
            message: 'Everthing is good',
          ).show(context);
        }
      },
      builder: (context, state) {
        if (state is UserErrorState) {
          uberDriverProvider = uberLastState;
        } else {
          uberDriverProvider = state as UberDriverState;
        }
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniStartFloat,
          floatingActionButton: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<UserPreferenceBloc>(context)
                      .add(SwitchUserMode());
                  Navigator.pushNamed(context, '/');
                },
                child: const Text('SM'),
              ),
              SizedBox(
                height: 20,
              ),
              if (uberDriverProvider.destination != null &&
                  uberDriverProvider.directions.isNotEmpty)
                FloatingActionButton(
                  backgroundColor: Colors.blue,
                  onPressed: () {
                    if (isTripStarted == false) {
                      isTripStarted = true;
                      BlocProvider.of<UberDriverBloc>(context).add(StartTrip(
                          passengerRequest:
                              uberDriverProvider.acceptedRequest!));
                    } else {
                      isTripStarted = false;
                      BlocProvider.of<UberDriverBloc>(context).add(EndTrip(
                          passengerRequest:
                              uberDriverProvider.acceptedRequest!));
                    }
                  },
                  child: Text(
                    (isTripStarted) ? tripStates[1] : tripStates[0],
                    style: TextStyle(color: Colors.white),
                  ),
                ),
            ],
          ),
          body: Stack(
              // alignment: Alignment.bottomCenter,
              children: [
                DriverGoogleMapWidget(
                  isTripStarted: isTripStarted,
                ),
                if (uberDriverProvider.destination != null &&
                    driverMapProvider.state.bottomSheet == true)
                  DriverDraggableSheet(),
                BlocConsumer<DriverMapBloc, DriverMapState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    return SafeArea(
                      child: LayoutBuilder(
                        builder: (context, constraints) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          margin: const EdgeInsets.all(0),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(50))),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(child: DriverMapSwitch()),
                                  Expanded(
                                      flex: 2,
                                      child: Center(
                                          child: const Text('Receive Orders'))),
                                  Expanded(child: DriverGpsIcon()),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              if (driverMapProvider.state.topSheet == true)
                                SizedBox(
                                    height: constraints.maxHeight * 0.5,
                                    child:
                                        (uberDriverProvider.acceptedRequest ==
                                                null)
                                            ? UserRequestListView()
                                            : UserInformation(true))
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ]),
        );
      },
    );
  }
}

// class TabListView extends StatefulWidget {
//   ScrollController controller;
//   TabListView(this.controller);

//   @override
//   State<TabListView> createState() => _TabListViewState();
// }

// class _TabListViewState extends State<TabListView> {
//   @override
//   Color? directionColor = Colors.green;

//   Color? infoColor = null;

//   Widget build(BuildContext context) {
//     return ListView(
//       controller: widget.controller,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextButton(
//                 style: TextButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(0)),
//                     backgroundColor: directionColor),
//                 onPressed: () {
//                   if (directionColor != Colors.green) {
//                     directionColor = Colors.green;
//                     infoColor = null;
//                     setState(() {});
//                   }
//                 },
//                 child: Text('Directions')),
//             TextButton(
//                 style: TextButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(0)),
//                     backgroundColor: infoColor),
//                 onPressed: () {
//                   if (infoColor != Colors.green) {
//                     infoColor = Colors.green;
//                     directionColor = null;
//                     setState(() {});
//                   }
//                 },
//                 child: Text('User Information')),
//           ],
//         ),
//         (directionColor == Colors.green)
//             ? BlocConsumer<UberDriverBloc, MapUserState>(
//                 listener: (context, state) {
//                   // TODO: implement listener
//                 },
//                 builder: (context, state) {
//                   return DirectionWidget(widget.controller);
//                 },
//               )
//             : UserInformation()
//       ],
//     );
//   }
// }




