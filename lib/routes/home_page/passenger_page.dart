import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google%20map_states.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_bloc.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_events.dart';
import 'package:tawsela_app/models/bloc_models/user_preferences/user_preference_bloc.dart';
import 'package:tawsela_app/models/bloc_models/user_preferences/user_preference_events.dart';
import 'package:tawsela_app/models/data_models/user_states.dart';
import 'package:tawsela_app/routes/home_page/bottom_sheet/bottom_sheet.dart';

class PassengerPage extends StatefulWidget {
  const PassengerPage({super.key});

  @override
  State<PassengerPage> createState() => _PassengerPageState();
}

class _PassengerPageState extends State<PassengerPage> {
  final textController = TextEditingController();
  List<String> tripStates = ['Start Trip', 'End Trip'];
  bool isTripStarted = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PassengerBloc, PassengerState>(
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
        final googleMapProvider = BlocProvider.of<PassengerBloc>(context);
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
                  onPressed: () {},
                  child: const Text(
                    'Start trip',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
            ],
          ),
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          body: Stack(
              // alignment: Alignment.bottomCenter,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) => SizedBox(
                      height: (state.destination != null)
                          ? constraints.maxHeight * 0.93
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
                                          target: LatLng(
                                              snapshot.data!.latitude,
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
                              initialCameraPosition: CameraPosition(
                                  target: state.currentPosition))),
                ),
                if (state.destination != null)
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
                              UserActionsPanel()
                            ],
                          ),
                        );
                      }),
                LayoutBuilder(
                  builder: (context, constraints) => Padding(
                    padding:
                        const EdgeInsets.only(top: 50, left: 15, right: 10),
                    child: Row(
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                              maxWidth: constraints.maxWidth * 0.79,
                              maxHeight: constraints.maxHeight * 0.07,
                              minHeight: constraints.maxHeight * 0.07),
                          child: GooglePlaceAutoCompleteTextField(
                            inputDecoration: const InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.only(left: 0),
                              hintText: 'Search',
                              border: null,
                            ),
                            textEditingController: textController,
                            googleAPIKey:
                                '***REMOVED***',
                            boxDecoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            countries: const ['eg'],
                            itemBuilder: (context, index, prediction) {
                              return ListTile(
                                leading: const Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                ),
                                title: Text(prediction.description!),
                              );
                            },
                            showError: true,
                            itemClick: (prediction) async {
                              FocusScope.of(context).unfocus();
                              if (prediction.description != null) {
                                List<Location> location =
                                    await locationFromAddress(
                                        prediction.description!);

                                googleMapProvider.add(GetDestination(
                                    destinationDescription:
                                        prediction.description!,
                                    destination: LatLng(location[0].latitude,
                                        location[0].longitude)));
                              }
                            },
                          ),
                        ),
                        IconButton(
                            style: IconButton.styleFrom(
                                backgroundColor: Colors.white),
                            onPressed: () {
                              googleMapProvider
                                  .add(const GoogleMapGetCurrentPosition());
                            },
                            icon: const Icon(
                              Icons.gps_fixed,
                              color: Colors.green,
                            ))
                      ],
                    ),
                  ),
                ),
              ]),
        );
      },
    );
  }
}
