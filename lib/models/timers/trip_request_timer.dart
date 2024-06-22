import 'dart:async';

class TripRequestTimer {
  Timer? _requestTimer;
  Timer? _tripTimer;
  final Future<void> Function() tripCallback;
  final Future<void> Function() requestCallback;
  Duration duration;

  TripRequestTimer({
    required this.requestCallback,
    required this.tripCallback,
    required this.duration,
  });

  void startTripTimer() {
    _tripTimer = Timer.periodic(duration, (timer) async {
      try {
        await tripCallback();
      } catch (error) {
        print('Error in trip timer');
      }
    });
  }

  void startRequestTimer() {
    _requestTimer = Timer.periodic(duration, (timer) async {
      try {
        await requestCallback();
      } catch (error) {
        print('Error in request timer');
      }
    });
  }

  void stopTripTimer() {
    if (_tripTimer != null) {
      _tripTimer!.cancel();
    }
  }

  void stopRequestTimer() {
    if (_requestTimer != null) {
      _requestTimer!.cancel();
    }
  }
}
