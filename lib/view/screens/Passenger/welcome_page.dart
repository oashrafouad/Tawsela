import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/models/bloc_models/lang/app_language_bloc.dart';
import 'package:tawsela_app/utilities.dart';
import 'package:tawsela_app/view/screens/Passenger/sms_verfication.dart';

import 'package:tawsela_app/view/widgets/custom_button.dart';
import 'package:tawsela_app/view/widgets/custom_text_field.dart';
String phoneNumber='';
class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});
  static String id = 'WelcomePage';
  
  final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: noColor,
        shadowColor: Colors.black,
        leading: PopupMenuButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Color(0xffB4B4B4), width: 0.5),
          ),
          icon: const Icon(Icons.language),
          popUpAnimationStyle: AnimationStyle(curve: Curves.easeIn),
          color: Colors.white,
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 1,
              child: Center(
                  child: Text("English",
                      style: TextStyle(
                          fontFamily: font, color: kGreenBigButtons))),
            ),
            const PopupMenuItem(
              value: 2,
              child: Center(
                  child: Text(
                "العربية",
                style: TextStyle(fontFamily: font, color: kGreenBigButtons),
              )),
            ),
          ],
          elevation: 2,
          onSelected: (value) {
            if (value == 1) {
              BlocProvider.of<AppLanguageBloc>(context)
                  .add(EnglishLanguageEvent());
            } else if (value == 2) {
              BlocProvider.of<AppLanguageBloc>(context)
                  .add(ArabicLanguageEvent());
            }
          },
        ),
        iconTheme: const IconThemeData(color: kGreenBigButtons),
      ),


      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  S.of(context).title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                    fontFamily: font,
                  ),
                ),
              ),
              Text(
                S.of(context).appName,
                style: const TextStyle(
                  color: kGreenFont,
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                  fontFamily: font,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  height: MediaQuery.of(context).size.height * .18,
                  child: Text(
                    S.of(context).welcomeMsg,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: font,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, right: 0, left: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextFormField(
                      textAlign: isArabic() ? TextAlign.end : TextAlign.start,
                      titleAbove: S.of(context).phoneNum,
                      height: 46,
                      width: 230,
                      hintText: "1234567890",
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      onChanged: (value) {
                        phoneNumber=value;
                      },
                      
                      //controller: phoneController,
                      inputFormatters: [
                        // prevent the first number inputted to be 0, to force the user to input the correct number format
                        FilteringTextInputFormatter.deny(RegExp(r'^0')),
                        // to only allow (english) numbers
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
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
                                fontWeight: FontWeight.w400, fontSize: 15),
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
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: CustomButton(
              width: 300,
              radius: 10,
              buttonColor: kGreenBigButtons,
              textColor: kWhite,
              text: S.of(context).continuee,
              onTap: () {
                
                Navigator.pushNamed(context, SmsVerficationPage.id);
              },
            ),
          ),
          
     
        ],
      ),
    );
  }
}
