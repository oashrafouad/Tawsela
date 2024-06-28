import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/loading_status_handler.dart';
import 'package:tawsela_app/services/API_service.dart';

import 'package:tawsela_app/utilities.dart';
import 'package:tawsela_app/view/screens/Passenger/passenger_main_screen.dart';
import 'package:tawsela_app/view/screens/Passenger/passenger_signup.dart';
import 'package:tawsela_app/view/widgets/custom_button.dart';
import 'package:tawsela_app/view/widgets/custom_text_field.dart';

class SmsVerficationPage extends StatelessWidget {
  SmsVerficationPage({super.key});

  static String id = 'SmsVerficationPage';
  String smsCode = '';

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
                  autofillHints: [AutofillHints.oneTimeCode],
                  textInputAction: TextInputAction.done,
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
                    bool accountExists = false;
                    // Sign the user in (or link) with the credential
                    try {
                      // await FirebaseAuth.instance.signInWithCredential(credential);

                      await account!.createSession(
                        userId: userId,
                        secret: smsCode,
                      );
                      print("Logged in successfully");

                      // final session = await account!.createAnonymousSession();
                      // print(session.userId);

                      LoadingStatusHandler.completeLoadingWithText("تم التحقق");
                        try {
                          accountExists = await ApiService.checkAccountExists(phoneNumber: phoneNumber);
                        } catch (e) {
                          print("ERROR CHECKING ACCOUNT EXISTS: $e");
                        }
                        // print(accountExists);
                        // print("printed");
                        // ApiService.getUserInfo(phoneNumber: phoneNumber);
                        // await updateData();
                        if(accountExists){
                          // print("Profile image URL SECOND: $profileImageURL");
                          await getAllUserInfoAndAssignToVariables(phoneNumber: phoneNumber);
                          // print("done");
                          await updateDataToSharedPrefs();
                          Navigator.pushNamedAndRemoveUntil(context, PassengerMainScreen.id, (route) => false);
                        } else {
                          Navigator.pushNamed(context, PassengerSignUpPage.id);
                        }
                    } catch (e) {
                          LoadingStatusHandler.errorLoading("$e");
                          print("ERROR SIGNING IN: $e");

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
