import 'package:flutter/material.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/utilities.dart';
import 'package:tawsela_app/view/screens/Passenger/passengerMainScreen.dart';
import 'package:tawsela_app/view/widgets/customButton.dart';
import 'package:tawsela_app/view/widgets/customTextButton.dart';
import 'package:tawsela_app/view/widgets/customTextField.dart';

class PassengerSignUpPage extends StatelessWidget {
  const PassengerSignUpPage({super.key});

  static const String id = 'PassengerSignUpPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kGreenBigButtons),
      ),
      body: ListView(
       
        children: [
          _buildTitle(context),
          _buildNameFields(),
          const SizedBox(height: 16),
          _buildEmailField(context),
          const SizedBox(height: 16),
          _buildImageUpload(context),
          const SizedBox(height: 32),
          _buildSignUpButton(context),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 100),
      child: Center(
        child: Text(
          S.of(context).passengerSignUpTitle,
          style: const TextStyle(
            fontFamily: font,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildNameFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextFormField(
            width: 136,
            height: 46,
            titleAbove: S.current.firstName,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextFormField(
            width: 136,
            height: 46,
            titleAbove: S.current.lastName,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return Center(
      child: CustomTextFormField(
        textAlign: isArabic() ? TextAlign.end : TextAlign.start,
        width: 284,
        height: 46,
        titleAbove: S.of(context).email,
      ),
    );
  }

  Widget _buildImageUpload(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                S.of(context).personalImage,
                style: const TextStyle(
                  fontFamily: font,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: kGreyFont,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextButton(
                  onTap: () {
                    showImagePicker(context);
                  },
                  icon: Icons.image,
                  text: S.of(context).uploadImg,
                  radius: 16,
                  fontSize: 14,
                  iconSize: 19,
                  paddingHorzin: 10,
                  paddingVerti: 10,
                ),
              ],
            )
          ],
        ),
        Container(width: 180),
      ],
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return CustomButton(
      text: S.of(context).signUp,
      onTap: () {
        Navigator.pushNamed(context, PassengerMainScreen.id);
      },
    );
  }
}
