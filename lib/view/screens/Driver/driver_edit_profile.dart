import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/models/bloc_models/imageCubit/image_cubit.dart';
import 'package:tawsela_app/utilities.dart';
import 'package:tawsela_app/view/screens/Passenger/passenger_signup.dart';
import 'package:tawsela_app/view/widgets/custom_button.dart';

import 'package:tawsela_app/view/widgets/custom_text_button.dart';
import 'package:tawsela_app/view/widgets/custom_text_field.dart';

class DriverEditProfilePage extends StatelessWidget {
  DriverEditProfilePage({super.key});
  static String id = 'DriverEditProfilePage';
  List<String> titlesAboveUploadImgButton = [
    S().personalImage,
    S().licenseImg,
    S().idCardImg
  ];
  @override
  Widget build(BuildContext context) {
    final imageState = context.watch<ImageCubit>().state;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          S.of(context).editProfile,
          style: const TextStyle(
              fontFamily: font, fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 8,
                    right: isArabic() ? 28 : 0,
                    left: isArabic() ? 0 : 28),
                child: Text(
                  S.of(context).personalImage,
                  style: const TextStyle(
                      fontFamily: font,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: imageState.avatarImg.image,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextFormField(
                  textDirection:
                      isArabic() ? TextDirection.rtl : TextDirection.ltr,
                  textAlign: isArabic() ? TextAlign.right : TextAlign.left,
                  hintText: firstName,
                  width: 136,
                  height: 46,
                  titleAbove: S.of(context).firstName,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextFormField(
                  textDirection:
                      isArabic() ? TextDirection.rtl : TextDirection.ltr,
                  textAlign: isArabic() ? TextAlign.right : TextAlign.left,
                  hintText: lastName,
                  width: 136,
                  height: 46,
                  titleAbove: S.of(context).lastName,
                ),
              )
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              S
                  .of(context)
                  .ToEditTheNameAndProfilePictureContactTechnicalSupport,
              style: const TextStyle(
                  color: Color(0xff9D9D9D),
                  fontFamily: font,
                  fontSize: 10,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 16, left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextFormField(
                       inputFormatters: [
                      // prevent the first number inputted to be 0, to force the user to input the correct number format
                      FilteringTextInputFormatter.deny(RegExp(r'^0')),
                      // to only allow (english) numbers
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    maxLength: 10,
                      textAlign: TextAlign.left,
                      textDirection: TextDirection.ltr,
                      titleAbove: S.of(context).phoneNum,
                      height: 46,
                      width: 213,
                      hintText: "123456789",
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 24.0),
                      child: SizedBox(
                          height: 20,
                          width: 29,
                          child: Text(
                            '20+',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 16),
                          )),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 28.0),
                      child: SizedBox(
                          height: 23,
                          width: 23,
                          child: Image.asset('assets/images/flag.png')),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Center(
                  child: CustomTextFormField(
                    hintText: email,
                    keyboardType: TextInputType.emailAddress,
                    textDirection: TextDirection.ltr,
                    textAlign:  TextAlign.left ,
                    width: 284,
                    height: 46,
                    titleAbove: S.of(context).email,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          for (int i = 1; i < 3; i++)
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
                      titlesAboveUploadImgButton[
                          i], //S.of(context).personalImage,
                      style: const TextStyle(
                          fontFamily: font,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff444444)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: isArabic() ? 16 : 0, left: isArabic() ? 0 : 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomTextButton(
                          onTap: () {},
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
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                ],
              ),
            ),
          // SizedBox(height: 32,),

          CustomButton(
            onTap: () {
              Navigator.pop(context);
            },
            radius: 6,
            width: 284,
            height: 54,
            text: S.of(context).save,
          ),
          const SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}
