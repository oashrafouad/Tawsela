import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/models/bloc_models/DriverStateTextBloc/driver_state_text_bloc.dart';
import 'package:tawsela_app/models/bloc_models/DriverStateTextBloc/driver_state_text_state.dart';
import 'package:tawsela_app/view/screens/Driver/driver_pickup_location.dart';
import 'package:tawsela_app/view/screens/driver_map_page/driver_map_switch.dart';


class MicrobusSuggestedLinesPage extends StatelessWidget {
  const MicrobusSuggestedLinesPage({super.key});
  static String id = 'MicrobusSuggestedLinesPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kGreenBigButtons),
        
      ),
      body: Stack(
      
        children: [
          Container(
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
                              
                              
                             
                            ],
                          ),
                        ),
        ],
        
      ),
    );
  }
}
