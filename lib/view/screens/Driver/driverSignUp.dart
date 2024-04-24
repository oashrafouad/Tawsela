import 'package:flutter/material.dart';

import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';

import 'package:tawsela_app/utilities.dart';
import 'package:tawsela_app/view/widgets/customButton.dart';
import 'package:tawsela_app/view/widgets/customTextButton.dart';


class DriverSignUpPage extends StatelessWidget {
   DriverSignUpPage({super.key});
   static String id ='DriverSignUpPage';
   List<String> titlesAboveUploadImgButton = [
  S().personalImage,
  S().licenseImg,
  S().idCardImg
];
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 100,horizontal: 16),
            child: Text(
              S.of(context).signUpDriverMsg,
              style: const TextStyle(
                fontFamily: font,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          
          for (int i=0;i<3;i++)
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
                    titlesAboveUploadImgButton[i],  //S.of(context).personalImage,
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
          const SizedBox(height: 32,),
          CustomButton(
            text: S.of(context).continuee
            ,
          )
        ],
      ),
    );
  }
}
