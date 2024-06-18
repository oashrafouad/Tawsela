import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/loading_status_handler.dart';

import 'package:tawsela_app/utilities.dart';
import 'package:tawsela_app/view/screens/Passenger/passenger_signup.dart';
import 'package:tawsela_app/view/widgets/custom_button.dart';
import 'package:tawsela_app/view/widgets/custom_text_field.dart';

class SmsVerficationPage extends StatelessWidget {
  SmsVerficationPage({super.key, required this.verificationId, required this.phoneNumber});

  static String id = 'SmsVerficationPage';
  String verificationId;
  String phoneNumber;
  String smsCode = '123456';

  LoadingStatusHandler loadingStatusHandler = LoadingStatusHandler();

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // print(verificationId);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kGreenBigButtons),
      ),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(
                  S.of(context).smsVerificationScreenTitle,
                  style: const TextStyle(
                    fontFamily: font,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextFormField(
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.start,
                  width: 284,
                  height: 46,
                  maxLength: 6, //verification code should be 6 digits
                  titleAbove: S.of(context).verifyCode,
                  keyboardType: TextInputType.phone,
                  initialValue: smsCode,
                  onChanged: (value) => smsCode = value,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: isArabic() ? 32 : 0,
                      right: isArabic() ? 0 : 32,
                      top: 8),
                  child: SizedBox(
                    width: 320,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () async {
                            loadingStatusHandler.startLoading();
                            // The expected behavior is that Firebase sends same SMS code 3 times, then it sends a different one
                            await FirebaseAuth.instance.verifyPhoneNumber(
                              phoneNumber: "+20$phoneNumber",
                              verificationFailed: (FirebaseAuthException e) {
                                switch (e.code) {
                                  case 'invalid-phone-number':
                                    loadingStatusHandler.errorLoading(
                                        "الرقم الذي ادخلته غير صحيح");
                                    print(
                                        "ERROR SENDING SMS CODE: ${e.code}, ${e.message}");
                                    break;
                                  case 'network-request-failed':
                                    loadingStatusHandler.errorLoading(
                                        "تأكد من اتصالك بالانترنت");
                                    print(
                                        "ERROR SENDING SMS CODE: ${e.code}, ${e.message}");
                                    break;
                                  default:
                                    loadingStatusHandler
                                        .errorLoading("${e.message}");
                                    print(
                                        "ERROR SENDING SMS CODE: ${e.code}, ${e.message}");
                                }
                              },
                              codeSent:
                                  (String verificationId, int? resendToken) {
                                print("SUCCESSFULLY SENT SMS CODE");
                                loadingStatusHandler.completeLoadingWithText(
                                    "تم ارسال الكود مرة اخرى");
                              },
                              // implementation not needed
                              verificationCompleted: (PhoneAuthCredential credential) {},
                              // implementation not needed
                              codeAutoRetrievalTimeout: (String verificationId) {},
                            );
                          },
                          splashFactory: splashEffect,
                          child: Text(
                            S.of(context).sendCodeAgain,
                            style: const TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: kGreenBigButtons,
                                fontFamily: font,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: kGreenBigButtons),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: CustomButton(
                //width: 300,
                text: S.of(context).continuee,
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    // print(smsCode);

                    loadingStatusHandler.startLoading();

                    // Create a PhoneAuthCredential with the code
                    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

                    // Sign the user in (or link) with the credential
                    try {
                      await FirebaseAuth.instance.signInWithCredential(credential);
                      loadingStatusHandler.completeLoadingWithText("تم التحقق").then((_) {
                        Navigator.pushNamed(context, PassengerSignUpPage.id);
                      });
                    } on FirebaseAuthException catch (e) {
                      switch (e.code) {
                        case 'invalid-verification-code':
                          loadingStatusHandler.errorLoading("الكود الذي ادخلته غير صحيح");
                          print("ERROR SIGNING IN: ${e.code}, ${e.message}");
                          break;
                        case 'network-request-failed':
                          loadingStatusHandler.errorLoading("تأكد من اتصالك بالانترنت");
                          print("ERROR SIGNING IN: ${e.code}, ${e.message}");
                          break;
                        default:
                          loadingStatusHandler.errorLoading("${e.message}");
                          print("ERROR SIGNING IN: ${e.code}, ${e.message}");
                      }
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Center(
                            child: Text(
                          "${S.of(context).PleaseEnter} ${S.of(context).verifyCode}",
                          style: const TextStyle(fontFamily: font),
                        )),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
