import 'package:flutter/material.dart';

import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';

import 'package:tawsela_app/utilities.dart';
import 'package:tawsela_app/view/screens/Driver/driverSignUp.dart';

import 'package:tawsela_app/view/screens/Passenger/passengerMainScreen.dart';

import 'package:tawsela_app/view/widgets/customButton.dart';
import 'package:tawsela_app/view/widgets/customTextButton.dart';
import 'package:tawsela_app/view/widgets/customTextField.dart';

String firstName = '', lastName = '';
String? email;
//var avatarImg;
class PassengerSignUpPage extends StatelessWidget {
  const PassengerSignUpPage({super.key});
  static String id = 'PassengerSignUpPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kGreenBigButtons),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 100),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextFormField(
                  onChanged: (data) => firstName = data,
                  width: 136,
                  height: 46,
                  titleAbove: S.of(context).firstName,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextFormField(
                  onChanged: (data) => lastName = data,
                  width: 136,
                  height: 46,
                  titleAbove: S.of(context).lastName,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Center(
            child: CustomTextFormField(
              onChanged: (data) => email = data,
              textAlign: isArabic() ? TextAlign.end : TextAlign.start,
              width: 284,
              height: 46,
              titleAbove: S.of(context).email,
              //inputFormatters: [FilteringTextInputFormatter.allow()],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8,
                    ),
                    child: Text(
                      S.of(context).personalImage,
                      style: const TextStyle(
                          fontFamily: font,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: kGreyFont),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextButton(
                        onTap: () {
                          
                          //showImagePicker(context,avatarImg);
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
              Container(
                width: 180,
              ),
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          CustomButton(
            text: S.of(context).signUp,
            onTap: () {
              Navigator.pushNamed(context, PassengerMainScreen.id);
            },
          )
        ],
      ),
    );
  }
}
