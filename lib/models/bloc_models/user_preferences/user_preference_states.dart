import 'package:equatable/equatable.dart';
import 'package:google_directions_api/google_directions_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tawsela_app/models/data_models/path_model/path.dart';
import 'package:tawsela_app/models/data_models/user_data.dart';
import 'package:tawsela_app/models/data_models/user_states.dart';

class NeverEqualState extends Equatable {
  const NeverEqualState();
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class UserPreferenceState extends NeverEqualState {
  final bool darkMode;
  final UserState userState;

  UserPreferenceState(
      {this.darkMode = false, this.userState = UserState.DRIVER});

  @override
  List<Object?> get props => [
        userState,
        darkMode,
      ];
}
