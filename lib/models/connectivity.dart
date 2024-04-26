import 'dart:async';

import 'package:connectivity/connectivity.dart';

class InternetConnection {
  late ConnectivityResult result;
  Stream<ConnectivityResult> connectivityResult =
      Connectivity().onConnectivityChanged;
  late StreamSubscription<ConnectivityResult> subscription;
  InternetConnection() {
    subscription = this.connectivityResult.listen((event) {
      result = event;
    });
    void cancelStream() {
      this.subscription.cancel();
    }
  }
}
