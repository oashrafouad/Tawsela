import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html/parser.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_bloc.dart';

class DirectionWidget extends StatefulWidget {
  @override
  DirectionWidget();
  State<DirectionWidget> createState() => _DirectionWidgetState();
}

class _DirectionWidgetState extends State<DirectionWidget> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final uberDriverProvider = BlocProvider.of<UberDriverBloc>(context);

    if (uberDriverProvider.state.directions.isNotEmpty &&
        uberDriverProvider.state.destination != null) {
      return ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 1,
            child: Stepper(
              steps: uberDriverProvider.state.directions.map((e) {
                final document = parse(e.instructions);
                final String parsedString =
                    parse(document.body!.text).documentElement!.text;
                return Step(
                    title: Text(e.duration!.text!),
                    subtitle: Text(e.distance!.text!),
                    content: Text(parsedString));
              }).toList(),
              onStepContinue: () {
                if (currentStep <
                    uberDriverProvider.state.directions.length - 1) {
                  currentStep += 1;
                  setState(() {});
                }
              },
              onStepCancel: () {
                if (currentStep > 0) {
                  currentStep -= 1;
                  setState(() {});
                }
              },
              connectorColor:
                  MaterialStateProperty.resolveWith((states) => Colors.green),
              currentStep: currentStep,
            ),
          ),
        ],
      );
    } else if (uberDriverProvider.state.destination == null) {
      return Center(
        child: Card(
          color: Colors.red,
          child: Text(
            'Unkown destination',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } else if (uberDriverProvider.state.directions.isEmpty) {
      return Center(
        child: CircularProgressIndicator(
          color: Colors.green,
        ),
      );
    } else {
      return ErrorWidget('An Error has occured');
    }
  }
}
