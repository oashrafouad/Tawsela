import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google%20map_states.dart';
import 'package:tawsela_app/models/data_models/google_server.dart';
import 'package:tawsela_app/models/passenger_bloc/passenger_bloc.dart';
import 'package:tawsela_app/models/passenger_bloc/passenger_events.dart';
import 'package:tawsela_app/models/passenger_bloc/passenger_states.dart';

class PassengerSearchBar extends StatefulWidget {
  PassengerSearchBar({super.key});

  @override
  State<PassengerSearchBar> createState() => _PassengerSearchBarState();
}

class _PassengerSearchBarState extends State<PassengerSearchBar> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    late PassengerState googleMapProvider;
    if (BlocProvider.of<PassengerBloc>(context).state is UserErrorState) {
      googleMapProvider = passengerLastState;
    } else if (BlocProvider.of<PassengerBloc>(context).state is Loading) {
      googleMapProvider = passengerLastState;
    } else {
      googleMapProvider =
          BlocProvider.of<PassengerBloc>(context).state as PassengerState;
    }
    return GooglePlaceAutoCompleteTextField(
      textStyle: const TextStyle(fontFamily: font),
      inputDecoration: InputDecoration(
       
        prefixIcon: const Icon(Icons.search),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: kSearchBarColor)),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(color: kSearchBarColor)),
            
        contentPadding: const EdgeInsets.only(left: 0),
        hintText: S.of(context).whereUwantoGo,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide()),
            
      ),
      textEditingController: textController,
      googleAPIKey: GetIt.instance.get<GoogleServer>().url,
      boxDecoration: BoxDecoration(
          color: kSearchBarColor, borderRadius: BorderRadius.circular(20)),
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
              await locationFromAddress(prediction.description!);

          BlocProvider.of<PassengerBloc>(context).add(GetDestination(
              destinationDescription: prediction.description!,
              destination:
                  LatLng(location[0].latitude, location[0].longitude)));
        }
      },
    );
  }
}
