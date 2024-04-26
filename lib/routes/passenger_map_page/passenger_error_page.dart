import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_bloc.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_events.dart';

class PassengerErrorPage extends StatelessWidget {
  const PassengerErrorPage(this.message, {super.key});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(message),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<PassengerBloc>(context)
                      .add(GoogleMapGetCurrentPosition());
                },
                child: Text('Refresh'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
