import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tawsela_app/models/data_models/request_model.dart';
import 'package:tawsela_app/models/data_models/user_data.dart';
import 'package:tawsela_app/models/data_models/user_states.dart';

abstract class DriverMapEvent extends Equatable {
  const DriverMapEvent();
  @override
  List<Object> get props => [];
}

class ShowTopSheet extends DriverMapEvent {
  const ShowTopSheet();
}

class ShowBottomSheet extends DriverMapEvent {
  const ShowBottomSheet();
}

class HideBottomSheet extends DriverMapEvent {
  const HideBottomSheet();
}

class HideTopSheet extends DriverMapEvent {
  const HideTopSheet();
}
