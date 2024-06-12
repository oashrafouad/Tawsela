import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';

import 'package:tawsela_app/utilities.dart';
import 'package:tawsela_app/view/screens/Passenger/passenger_signup.dart';
import 'package:tawsela_app/view/widgets/custom_button.dart';
import 'package:tawsela_app/view/widgets/custom_text_field.dart';


class SmsVerficationPage extends StatelessWidget {
   SmsVerficationPage({super.key});
  static String id = 'SmsVerficationPage';
   String verifyCode='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kGreenBigButtons),
      ),
      body: Column(
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
                textAlign: TextAlign.end,
                width: 284,
                height: 46,
                maxLength: 6, //verification code should be 6 digits
                titleAbove: S.of(context).verifyCode,
                keyboardType: TextInputType.phone,
                onChanged: (value) => verifyCode=value,
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
                        onTap: () {
                          // TODO: implement send code again
                          // We can use the same function that sends the code in the first place
                          // We can use SVProgressHUD to show a loading indicator, then show a success message
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
              onTap: () {
                Navigator.pushNamed(context, PassengerSignUpPage.id);
              },
            ),
          )
        ],
      ),
    );
  }
}
