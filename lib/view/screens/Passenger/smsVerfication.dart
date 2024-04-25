import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/utilities.dart';
import 'package:tawsela_app/view/screens/Passenger/passengerSignUp.dart';
import 'package:tawsela_app/view/widgets/customButton.dart';
import 'package:tawsela_app/view/widgets/customTextField.dart';

class SmsVerificationPage extends StatelessWidget {
  const SmsVerificationPage({super.key});

  static const String id = 'SmsVerificationPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kGreenBigButtons),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTitle(context),
          _buildVerificationInput(context),
          _buildContinueButton(context),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: SizedBox(
        height: 40,
        width: 301,
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
    );
  }

  Widget _buildVerificationInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomTextFormField(
          textAlign: TextAlign.end,
          width: 284,
          height: 46,
          maxLength: 6,
          titleAbove: S.of(context).verifyCode,
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            left: isArabic() ? 32 : 0,
            right: isArabic() ? 0 : 32,
            top: 8,
          ),
          child: SizedBox(
            width: 320,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  S.of(context).sendCodeAgain,
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: kGreenBigButtons,
                    fontFamily: font,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: kGreenBigButtons,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: CustomButton(
        text: S.of(context).continuee,
        onTap: () {
          Navigator.pushNamed(context, PassengerSignUpPage.id);
        },
      ),
    );
  }
}
