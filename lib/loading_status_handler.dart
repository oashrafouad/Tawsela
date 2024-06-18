import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';

class LoadingStatusHandler {
  String _error = '';

  void startLoading() {
    SVProgressHUD.show();
  }

  void completeLoading() {
    // dismiss loading immediately without text
    SVProgressHUD.dismiss();
  }

  Future<void> completeLoadingWithText(String text) {
    // text to show when loading is completed
    SVProgressHUD.showSuccess(status: text);
    // Add delay of 1.5 seconds to match the duration of the success HUD
    return Future.delayed(const Duration(milliseconds: 1500));
  }


  void errorLoading(String error) {
    _error = error;
    SVProgressHUD.showError(status: "حدث خطأ، الرجاء المحاولة مرة اخرى\n$_error");
  }
}
