import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawsela_app/models/bloc_models/driver_map_bloc/driver_map_bloc.dart';
import 'package:tawsela_app/models/bloc_models/driver_map_bloc/driver_map_events.dart';
import 'package:tawsela_app/models/bloc_models/driver_map_bloc/driver_map_states.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google%20map_states.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_bloc.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_events.dart';

class DriverMapSwitch extends StatelessWidget {
  const DriverMapSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final driverMapProvider = BlocProvider.of<DriverMapBloc>(context);

    late UberDriverState uberDriverProvider;
    if (BlocProvider.of<UberDriverBloc>(context).state is UserErrorState) {
      uberDriverProvider = uberLastState;
    } else if (BlocProvider.of<UberDriverBloc>(context).state is Loading) {
      uberDriverProvider = uberLastState;
    } else {
      uberDriverProvider =
          BlocProvider.of<UberDriverBloc>(context).state as UberDriverState;
    }
    return BlocConsumer<DriverMapBloc, DriverMapState>(
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
              if (uberDriverProvider.acceptedRequest == null) {
                BlocProvider.of<DriverMapBloc>(context).add(ShowTopSheet());
                BlocProvider.of<UberDriverBloc>(context)
                    .add(GetPassengerRequests());
              } else {
                Flushbar(
                  message: 'you already has accepted a request',
                  backgroundColor: Colors.red,
                  messageColor: Colors.white,
                  duration: Duration(seconds: 1),
                ).show(context);
              }
            } else {
              BlocProvider.of<DriverMapBloc>(context).add(HideTopSheet());
            }
          },
          value: driverMapProvider.state.topSheet,
        );
      },
    );
  }
}
