import 'package:google_directions_api/google_directions_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google%20map_states.dart';
import 'package:tawsela_app/models/data_models/request_model.dart';
import 'package:tawsela_app/models/data_models/uber_driver.dart';
import 'package:tawsela_app/models/data_models/user_states.dart';

class UberDriverState extends GoogleMapState {
  final UberDriver? driver;
  final List<UserRequest> passengerRequests;
  final UserRequest? acceptedRequest;
  UberDriverState(
      {required GoogleMapController? controller,
      required UserState userState,
      required LatLng currentPosition,
      LatLng? destination,
      String currentLocationDescription = 'Unknown',
      String destinationDescription = 'Unknown',
      required List<Polyline> lines,
      required Set<Marker> markers,
      required List<Step> directions,
      required this.driver,
      this.passengerRequests = const [],
      this.acceptedRequest})
      : super(
          controller: controller,
          currentPosition: currentPosition,
          lines: lines,
          markers: markers,
          directions: directions,
          destination: destination,
          userState: UserState.DRIVER,
          currentLocationDescription: currentLocationDescription,
          destinationDescription: destinationDescription,
        );
}
