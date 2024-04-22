import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tawsela_app/models/data_models/request_model.dart';
import 'package:tawsela_app/models/data_models/user_data.dart';
import 'package:tawsela_app/models/data_models/user_states.dart';

abstract class UserPreferenceEvent extends Equatable {
  const UserPreferenceEvent();
  @override
  List<Object> get props => [];
}

class EnableDarkMode extends UserPreferenceEvent {
  const EnableDarkMode();
}

class DisableDarkMode extends UserPreferenceEvent {
  const DisableDarkMode();
}

class SwitchUserMode extends UserPreferenceEvent {
  const SwitchUserMode();
}
