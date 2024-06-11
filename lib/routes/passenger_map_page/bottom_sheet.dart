import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google%20map_states.dart';
import 'package:tawsela_app/models/passenger_bloc/passenger_bloc.dart';
import 'package:tawsela_app/models/passenger_bloc/passenger_events.dart';
import 'package:tawsela_app/models/passenger_bloc/passenger_states.dart';
import 'package:tawsela_app/routes/passenger_map_page/service_choice.dart';
import 'package:tawsela_app/routes/passenger_map_page/uber_choice.dart';
import 'package:tawsela_app/routes/passenger_map_page/walk_choice.dart';

class UserActionsPanel extends StatefulWidget {
  const UserActionsPanel({super.key});

  @override
  State<UserActionsPanel> createState() => _UserActionsPanelState();
}

class _UserActionsPanelState extends State<UserActionsPanel> {
  final ActiveColor = Colors.white;

  final DisableColor = Colors.black;

  late Color UberColor = DisableColor;

  late Color BusColor = DisableColor;

  late Color WalkColor = DisableColor;
  int selectedItem = -1;
  List<String> items = ['Uber', 'Micro bus', 'Walk'];
  Set<String> selectedItems = {};
  @override
  Widget build(BuildContext context) {
    late PassengerState passengerState;
    if (BlocProvider.of<PassengerBloc>(context).state is UserErrorState) {
      passengerState = passengerLastState;
    } else if (BlocProvider.of<PassengerBloc>(context).state is Loading) {
      passengerState = passengerLastState;
    } else {
      passengerState =
          BlocProvider.of<PassengerBloc>(context).state as PassengerState;
    }
    // TODO: implement build
    return SizedBox(
        width: double.infinity,

        // color: Colors.red,
        child: Column(
          children: [
            BlocListener<PassengerBloc, MapUserState>(
              listenWhen: (previous, current) {
                if (previous is PassengerState && current is Loading) {
                  return false;
                }
                if (previous is Loading && current is PassengerState) {
                  if (previous.message == getDestinationPlaceHolder) {
                    return true;
                  }
                }
                if (previous is PassengerState && current is PassengerState) {
                  if (previous.destination != current.destination) {
                    return true;
                  } else {
                    return false;
                  }
                }
                return false;
              },
              listener: (context, state) {
                selectedItem = -1;
                selectedItems = {};
                UberColor = WalkColor = BusColor = DisableColor;
                setState(() {});
              },
              child: SegmentedButton<String>(
                  emptySelectionAllowed: true,
                  style: SegmentedButton.styleFrom(
                      selectedBackgroundColor: Colors.green),
                  showSelectedIcon: true,
                  selectedIcon: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  segments: [
                    ButtonSegment(
                      value: items[0],
                      icon: const Icon(
                        Icons.car_repair,
                      ),
                      label: Text(
                        'Uber',
                        style: TextStyle(
                          color: UberColor,
                        ),
                      ),
                    ),
                    ButtonSegment(
                        value: items[1],
                        icon: const Icon(
                          Icons.bus_alert,
                        ),
                        label: Text(
                          'Service',
                          style: TextStyle(color: BusColor),
                        )),
                    ButtonSegment(
                        value: items[2],
                        icon: const Icon(
                          Icons.directions_walk,
                        ),
                        label: Text(
                          'Walk',
                          style: TextStyle(
                            color: WalkColor,
                          ),
                        )),
                  ],
                  selected: selectedItems,
                  onSelectionChanged: (Set<String> selection) =>
                      onSelect(selection, context)),
            ),
            BlocConsumer<PassengerBloc, MapUserState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Container(
                  child: (selectedItem == 0)
                      ? UberCoice()
                      : (selectedItem == 1)
                          ? ServiceChoice()
                          : (selectedItem == 2)
                              ? BlocConsumer<PassengerBloc, MapUserState>(
                                  buildWhen: (previous, current) {
                                    final c = current as PassengerState;
                                    return c.directions.isNotEmpty;
                                  },
                                  listener: (context, state) {
                                    // TODO: implement listener
                                  },
                                  builder: (context, state) {
                                    return WalkChoice();
                                  },
                                )
                              : Container(
                                  child: const Center(
                                  child: Card(
                                    margin: EdgeInsets.only(
                                        top: 50, left: 20, right: 20),
                                    color: Colors.green,
                                    child: Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: Text(
                                        'Choose the way you want to reach your destination from the above',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )),
                );
              },
            )
          ],
        ));
  }

  void onSelect(Set<String> selection, BuildContext context) {
    switch (selection.first) {
      case 'Uber':
        UberColor = ActiveColor;
        WalkColor = BusColor = DisableColor;
        selectedItem = 0;
        selectedItems = {items[selectedItem]};
        break;
      case 'Walk':
        WalkColor = ActiveColor;
        UberColor = BusColor = DisableColor;
        selectedItem = 2;
        selectedItems = {items[selectedItem]};
        var currentState;
        if (currentState is UserErrorState) {
          currentState = passengerLastState;
        } else {
          currentState =
              BlocProvider.of<PassengerBloc>(context).state as PassengerState;
          BlocProvider.of<PassengerBloc>(context, listen: false).add(
              GetWalkDirections(
                  passengerDestination:
                      currentState.destination ?? LatLng(0, 0)));
        }
        break;
      case 'Micro bus':
        BusColor = ActiveColor;
        UberColor = WalkColor = DisableColor;
        selectedItem = 1;
        selectedItems = {items[selectedItem]};
        BlocProvider.of<PassengerBloc>(context)
            .add(GetNearestPathToServiceLine());
        break;
    }
    setState(() {});
  }
}
