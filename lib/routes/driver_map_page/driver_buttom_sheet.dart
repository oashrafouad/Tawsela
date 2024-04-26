import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google%20map_states.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_bloc.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_events.dart';
import 'package:tawsela_app/routes/passenger_map_page/service_choice.dart';
import 'package:tawsela_app/routes/passenger_map_page/uber_choice.dart';
import 'package:tawsela_app/routes/passenger_map_page/walk_choice.dart';
import 'package:tawsela_app/routes/driver_map_page/directions.dart';
import 'package:tawsela_app/routes/driver_map_page/user_information.dart';

class DriverButtomSheet extends StatefulWidget {
  const DriverButtomSheet({super.key});

  @override
  State<DriverButtomSheet> createState() => _DriverButtomSheet();
}

class _DriverButtomSheet extends State<DriverButtomSheet> {
  final ActiveColor = Colors.white;

  final DisableColor = Colors.black;

  late Color directions = DisableColor;

  late Color userInformation = ActiveColor;
  int selectedItem = 1;
  List<String> items = ['Directions', 'User Information'];
  late Set<String> selectedItems = {items[1]};
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
        width: double.infinity,

        // color: Colors.red,
        child: Column(
          children: [
            BlocListener<PassengerBloc, MapUserState>(
              listenWhen: (previous, current) {
                final p = previous as PassengerState;
                final c = current as PassengerState;
                return p.destination != p.destination;
              },
              listener: (context, state) {
                selectedItem = 1;
                selectedItems = {items[1]};
                directions = DisableColor;
                userInformation = ActiveColor;
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
                        items[0],
                        style: TextStyle(
                          color: directions,
                        ),
                      ),
                    ),
                    ButtonSegment(
                        value: items[1],
                        icon: const Icon(
                          Icons.bus_alert,
                        ),
                        label: Text(
                          items[1],
                          style: TextStyle(color: userInformation),
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
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: DirectionWidget())
                        : UserInformation());
              },
            )
          ],
        ));
  }

  void onSelect(Set<String> selection, BuildContext context) {
    switch (selection.first) {
      case 'Directions':
        directions = ActiveColor;
        userInformation = DisableColor;
        selectedItem = 0;
        selectedItems = {items[selectedItem]};
        break;
      case 'User Information':
        userInformation = ActiveColor;
        userInformation = DisableColor;
        selectedItem = 1;
        selectedItems = {items[selectedItem]};
        break;
    }
    setState(() {});
  }
}
