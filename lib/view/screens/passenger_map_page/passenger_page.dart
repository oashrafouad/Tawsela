import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google%20map_states.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_events.dart';
import 'package:tawsela_app/models/bloc_models/user_preferences/user_preference_bloc.dart';
import 'package:tawsela_app/models/bloc_models/user_preferences/user_preference_events.dart';

import 'package:tawsela_app/view/screens/passenger_map_page/bottom_sheet.dart';
import 'package:tawsela_app/view/screens/passenger_map_page/loading_page.dart';
import 'package:tawsela_app/view/screens/passenger_map_page/passenger_google_map_page.dart';
import 'package:tawsela_app/view/screens/passenger_map_page/passenger_gps_icon.dart';
import 'package:tawsela_app/view/screens/passenger_map_page/passenger_search_bar.dart';
import 'package:tawsela_app/view/widgets/handle.dart';
import 'package:tawsela_app/models/passenger_bloc/passenger_bloc.dart';
import 'package:tawsela_app/models/passenger_bloc/passenger_events.dart';
import 'package:tawsela_app/models/passenger_bloc/passenger_states.dart';

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PassengerBloc, MapUserState>(
      listener: (context, state) {
        if (state is UserErrorState) {
          Flushbar(
            message: state.message,
            backgroundColor: Colors.red,
            messageColor: Colors.white,
            flushbarPosition: FlushbarPosition.BOTTOM,
            duration: const Duration(seconds: 2),
          ).show(context);
        } else {}
      },
      builder: (context, state) {
        PassengerState passengerState;
        if (state is UserErrorState) {
          passengerState = passengerLastState;
        } else if (state is Loading) {
          passengerState = passengerLastState;
        } else {
          passengerState =
              BlocProvider.of<PassengerBloc>(context).state as PassengerState;
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
                      .add(const SwitchUserMode());
                  Navigator.pushNamed(context, '/');
                },
                child: const Text('SM'),
              ),
              const SizedBox(
                height: 20,
              ),
              if (passengerState.destination != null &&
                  passengerState.directions.isNotEmpty)
                FloatingActionButton(
                  backgroundColor: Colors.blue,
                  onPressed: () {
                    if (isTripStarted == false) {
                      isTripStarted = true;
                      setState(() {});
                    } else {
                      isTripStarted = false;
                      BlocProvider.of<PassengerBloc>(context)
                          .add(const GoogleMapGetCurrentPosition());
                    }
                  },
                  child: Text(
                    (isTripStarted) ? tripStates[1] : tripStates[0],
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
            ],
          ),
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          body: Stack(

              // alignment: Alignment.bottomCenter,
              children: [
                PassengerGoogleMapWidget(
                  isTripStarted: isTripStarted,
                ),
                if (passengerState.destination != null)
                  DraggableScrollableSheet(
                      initialChildSize: 0.25,
                      minChildSize: 0.07,
                      maxChildSize: 1,
                      snapSizes: const [0.25, 0.5, 0.75, 1],
                      snap: true,
                      builder: (context, scrollableController) {
                        return Container(
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50))),
                          child: ListView(
                            physics: const ClampingScrollPhysics(),
                            controller: scrollableController,
                            children: const [
                              Column(
                                children: [BottomSheetHandle()],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              UserActionsPanel()
                            ],
                          ),
                        );
                      }),
                SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PassengerSearchBar(),
                      ),
                      const PassengerGpsIcon()
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<PassengerBloc>(context)
                              .add(const ShowLine(0));
                        },
                        child: const Text('Show lines')),
                  ],
                ),
                if (state is Loading) LoadingPage(state.message),
              ]),
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textController.dispose();
  }
}
