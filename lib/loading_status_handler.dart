import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';

class LoadingStatusHandler {
  static String _error = '';

  static void startLoading() {
    SVProgressHUD.show();
  }

  static void completeLoading() {
    // dismiss loading immediately without text
    SVProgressHUD.dismiss();
  }

  static Future<void> completeLoadingWithText(String text) {
    // text to show when loading is completed
    SVProgressHUD.showSuccess(status: text);
    // Add delay of 1.5 seconds to match the duration of the success HUD
    return Future.delayed(const Duration(milliseconds: 1500));
  }


  static void errorLoading(String error) {
    _error = error;
    SVProgressHUD.showError(status: "حدث خطأ، الرجاء المحاولة مرة اخرى\n$_error");
  }
}
