import 'package:flutter/material.dart';

import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/helper/checkLang.dart';
import 'package:tawsela_app/view/screens/Passenger/passengerMainScreen.dart';
import 'package:tawsela_app/view/widgets/customButton.dart';
import 'package:tawsela_app/view/widgets/customTextButton.dart';
import 'package:tawsela_app/view/widgets/customTextField.dart';

class PassengerSignUp extends StatelessWidget {
  const PassengerSignUp({super.key});
  static String id='passengerSignUpPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.green),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: Text(
              S.of(context).passengerSignUpTitle,
              style: TextStyle(
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
                  width: 136,
                  height: 46,
                  titleAbove: S.of(context).firstName,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextFormField(
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
              width: 284,
              height: 46,
              titleAbove: S.of(context).email,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: 8,
                      right: isArabic() ? 16 : 0,
                      left: isArabic() ? 0 : 16),
                  child: Text(
                    S.of(context).personalImage,
                    style: TextStyle(
                        fontFamily: font,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff444444)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: isArabic() ? 16 : 0, left: isArabic() ? 0 : 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomTextButton(
                        icon: Icons.image,
                        text: S.of(context).uploadImg,
                        radius: 16,
                        fontSize: 14,
                        iconSize: 19,
                        paddingHorzin: 10,
                        paddingVerti: 10,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          CustomButton(
            text: S.of(context).signUp,
            onTap: (){
              Navigator.pushNamed(context, PassengerMainScreen.id);
            },
          )
        ],
      ),
    );
  }
}