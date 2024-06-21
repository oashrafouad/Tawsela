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

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // print(verificationId);
    return Scaffold(
      appBar: AppBar(),
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

                    LoadingStatusHandler.startLoading();

                    // Create a PhoneAuthCredential with the code
                    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

                    // Sign the user in (or link) with the credential
                    try {
                      await FirebaseAuth.instance.signInWithCredential(credential);
                      LoadingStatusHandler.completeLoadingWithText("تم التحقق").then((_) {
                        Navigator.pushNamed(context, PassengerSignUpPage.id);
                      });
                    } on FirebaseAuthException catch (e) {
                      switch (e.code) {
                        case 'invalid-verification-code':
                          LoadingStatusHandler.errorLoading("الكود الذي ادخلته غير صحيح");
                          print("ERROR SIGNING IN: ${e.code}, ${e.message}");
                          break;
                        case 'network-request-failed':
                          LoadingStatusHandler.errorLoading("تأكد من اتصالك بالانترنت");
                          print("ERROR SIGNING IN: ${e.code}, ${e.message}");
                          break;
                        default:
                          LoadingStatusHandler.errorLoading("${e.message}");
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
