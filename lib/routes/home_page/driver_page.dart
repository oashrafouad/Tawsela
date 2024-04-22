import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:html/parser.dart';
import 'package:tawsela_app/models/bloc_models/driver_map_bloc/driver_map_bloc.dart';
import 'package:tawsela_app/models/bloc_models/driver_map_bloc/driver_map_events.dart';
import 'package:tawsela_app/models/bloc_models/driver_map_bloc/driver_map_states.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google%20map_states.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_bloc.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_events.dart';
import 'package:tawsela_app/models/bloc_models/user_preferences/user_preference_bloc.dart';
import 'package:tawsela_app/models/bloc_models/user_preferences/user_preference_events.dart';
import 'package:tawsela_app/models/data_base.dart';
import 'package:tawsela_app/models/data_base.dart';
import 'package:tawsela_app/models/data_models/request_model.dart';
import 'package:tawsela_app/models/data_models/user_states.dart';
import 'package:tawsela_app/routes/home_page/bottom_sheet/driver_buttom_sheet.dart';
import 'package:tawsela_app/routes/home_page/user_information.dart';

class DriverPage extends StatefulWidget {
  const DriverPage({super.key});
  @override
  State<DriverPage> createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  int acceptedTrip = -1;
  List<String> tripStates = ['Start Trip', 'End Trip'];
  bool isTripStarted = false;
  late Future<Position> currentLocationGetter;
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
    final uberDriverProvider = BlocProvider.of<UberDriverBloc>(context);
    return BlocConsumer<UberDriverBloc, UberDriverState>(
      listener: (context, state) {
        Flushbar(
          borderRadius: BorderRadius.circular(5),
          message: 'State has changed',
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.green,
          dismissDirection: FlushbarDismissDirection.VERTICAL,
          flushbarPosition: FlushbarPosition.TOP,
        ).show(context);
      },
      builder: (context, state) {
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
              if (state.destination != null && state.directions.isNotEmpty)
                FloatingActionButton(
                  backgroundColor: Colors.blue,
                  onPressed: () {
                    if (isTripStarted == false) {
                      isTripStarted = true;
                      BlocProvider.of<UberDriverBloc>(context).add(
                          StartTrip(passengerRequest: state.acceptedRequest!));
                    } else {
                      isTripStarted = false;
                      BlocProvider.of<UberDriverBloc>(context).add(
                          EndTrip(passengerRequest: state.acceptedRequest!));
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
                LayoutBuilder(
                  builder: (context, constraints) => SizedBox(
                    height: (state.destination != null)
                        ? constraints.maxHeight * 1
                        : constraints.maxHeight,
                    child: (isTripStarted)
                        ? StreamBuilder<Position>(
                            stream: Geolocator.getPositionStream(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData == true) {
                                return GoogleMap(
                                    onMapCreated:
                                        (GoogleMapController controller) {
                                      state.controller = controller;
                                    },
                                    markers: {
                                      ...state.markers,
                                      Marker(
                                          markerId: MarkerId('my-pos'),
                                          position: LatLng(
                                              snapshot.data!.latitude,
                                              snapshot.data!.longitude))
                                    },
                                    polylines: (state.lines.isNotEmpty)
                                        ? {...state.lines}
                                        : {},
                                    initialCameraPosition: CameraPosition(
                                        target: LatLng(snapshot.data!.latitude,
                                            snapshot.data!.longitude)));
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            })
                        : GoogleMap(
                            onMapCreated: (GoogleMapController controller) {
                              state.controller = controller;
                            },
                            markers: state.markers,
                            polylines: (state.lines.isNotEmpty)
                                ? {...state.lines}
                                : {},
                            initialCameraPosition:
                                CameraPosition(target: state.currentPosition)),
                  ),
                ),
                if (state.destination != null &&
                    driverMapProvider.state.bottomSheet == true)
                  DraggableScrollableSheet(
                      initialChildSize: 0.25,
                      minChildSize: 0.07,
                      maxChildSize: 1,
                      snapSizes: const [0.25, 0.5, 0.75, 1],
                      snap: true,
                      builder: (context, scrollableController) {
                        return Container(
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50))),
                          child: ListView(
                            physics: const ClampingScrollPhysics(),
                            controller: scrollableController,
                            children: const [
                              Column(
                                children: [
                                  SizedBox(
                                    width: 50,
                                    child: Divider(
                                      color: Colors.grey,
                                      thickness: 5,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              DriverButtomSheet(),
                            ],
                          ),
                        );
                      }),
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
                                  ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: constraints.maxWidth * 0.79,
                                          maxHeight:
                                              constraints.maxHeight * 0.07,
                                          minHeight:
                                              constraints.maxHeight * 0.07),
                                      child: BlocConsumer<DriverMapBloc,
                                          DriverMapState>(
                                        listener: (context, state) {
                                          // TODO: implement listener
                                        },
                                        builder: (context, state) {
                                          return Switch(
                                            inactiveThumbColor: Colors.green,
                                            inactiveTrackColor: Colors.white,
                                            activeColor: Colors.white,
                                            activeTrackColor: Colors.green,
                                            onChanged: (value) {
                                              if (value == true) {
                                                if (uberDriverProvider.state
                                                        .acceptedRequest ==
                                                    null) {
                                                  driverMapProvider
                                                      .add(ShowTopSheet());
                                                  uberDriverProvider.add(
                                                      GetPassengerRequests());
                                                } else {
                                                  Flushbar(
                                                    message:
                                                        'you already has accepted a request',
                                                    backgroundColor: Colors.red,
                                                    messageColor: Colors.white,
                                                    duration:
                                                        Duration(seconds: 1),
                                                  ).show(context);
                                                }
                                              } else {
                                                driverMapProvider
                                                    .add(HideTopSheet());
                                              }
                                            },
                                            value: driverMapProvider
                                                .state.topSheet,
                                          );
                                        },
                                      )),
                                  const Text('Receive Orders'),
                                  IconButton(
                                      style: IconButton.styleFrom(
                                          backgroundColor: Colors.green),
                                      onPressed: () {
                                        uberDriverProvider
                                            .add(GoogleMapGetCurrentPosition());
                                      },
                                      icon: const Icon(
                                        Icons.gps_fixed,
                                        color: Colors.white,
                                      ))
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              if (driverMapProvider.state.topSheet == true)
                                SizedBox(
                                    height: constraints.maxHeight * 0.5,
                                    child: (uberDriverProvider
                                                .state.acceptedRequest ==
                                            null)
                                        ? ListView.builder(
                                            itemCount: uberDriverProvider.state
                                                    .passengerRequests.isEmpty
                                                ? 0
                                                : uberDriverProvider.state
                                                    .passengerRequests.length,
                                            itemBuilder: (context, index) =>
                                                InkWell(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        backgroundColor:
                                                            const Color
                                                                .fromARGB(255,
                                                                238, 230, 230),
                                                        title: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                'User Information'),
                                                            IconButton(
                                                                icon: Icon(Icons
                                                                    .close),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                })
                                                          ],
                                                        ),
                                                        content: Container(
                                                          color: Colors.white,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(20.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child:
                                                                      CircleAvatar(
                                                                    child: Icon(
                                                                        Icons
                                                                            .person),
                                                                  ),
                                                                ),
                                                                Text(
                                                                    'name: ${uberDriverProvider.state.passengerRequests[index].passengerName}'),
                                                                Text(
                                                                    'location: ${uberDriverProvider.state.passengerRequests[index].currentLocationDescription}'),
                                                                Text(
                                                                    'destination: ${uberDriverProvider.state.passengerRequests[index].destinationDescription}')
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                              child: ListTile(
                                                contentPadding: EdgeInsets.zero,
                                                style: ListTileStyle.list,
                                                title: Text(userRequests[index]
                                                    .passengerName),
                                                leading: const CircleAvatar(
                                                  child: Icon(Icons.person),
                                                ),
                                                trailing: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    TextButton(
                                                        style: TextButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.green,
                                                        ),
                                                        onPressed: () {
                                                          if (uberDriverProvider
                                                                  .state
                                                                  .acceptedRequest ==
                                                              null) {
                                                            uberDriverProvider.add(
                                                                AcceptPassengerRequest(
                                                                    passengerRequest:
                                                                        userRequests[
                                                                            index]));
                                                          } else {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return AlertDialog(
                                                                    content: Text(
                                                                        'You can not accept more than one trip'),
                                                                  );
                                                                });
                                                          }
                                                        },
                                                        child: const Text(
                                                          'accept',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14),
                                                        )),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    TextButton(
                                                        style: TextButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.red,
                                                        ),
                                                        onPressed: () {
                                                          uberDriverProvider.add(
                                                              RejectPassengerRequest(
                                                                  passengerRequest:
                                                                      userRequests[
                                                                          index]));
                                                        },
                                                        child: const Text(
                                                            'reject',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14)))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
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
//             ? BlocConsumer<UberDriverBloc, UberDriverState>(
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




