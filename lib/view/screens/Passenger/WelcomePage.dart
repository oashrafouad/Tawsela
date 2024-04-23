import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/models/bloc_models/lang/app_language_bloc.dart';
import 'package:tawsela_app/models/bloc_models/theme/app_theme_bloc.dart';

import 'package:tawsela_app/view/screens/Passenger/smsVerfication.dart';
import 'package:tawsela_app/view/widgets/customButton.dart';
import 'package:tawsela_app/view/widgets/customGoogleIcon.dart';
import 'package:tawsela_app/view/widgets/customListTile.dart';

import 'package:tawsela_app/view/widgets/customTextField.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});
  static String id = 'WelcomePage';
  bool light = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () =>
                  BlocProvider.of<AppThemeBloc>(context).add(DarkEvent()),
              icon: const Icon(Icons.dark_mode_outlined)),
          IconButton(
              onPressed: () =>
                  BlocProvider.of<AppThemeBloc>(context).add(LightEvent()),
              icon: const Icon(Icons.light_mode_outlined))
        ],
        leading: PopupMenuButton<int>(
          icon: const Icon(Icons.language),
          popUpAnimationStyle: AnimationStyle(curve: Curves.easeIn
              // duration: Duration.
              ),
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
                    style:  TextStyle(
                      fontFamily: font,
                      color: sharedPreferences!.getString('theme')=='l'? Colors.black:Colors.amber,
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
                      titleAbove: S.of(context).phoneNum,
                      height: 46,
                      width: 230,
                      hintText: "1234567890",
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      // to only allow english numbers
                      inputFormatters: [
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 1.5,
                width: 150,
                color: kGreyFontLight,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  S.of(context).or,
                  style: const TextStyle(
                      fontFamily: font,
                      color: kGreyFont,
                      fontWeight: FontWeight.w300),
                ),
              ),
              Container(
                height: 1.5,
                width: 150,
                color: kGreyFontLight,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Container(
              height: MediaQuery.of(context).size.height * .3,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomListTile(
                      backgroundColor: kGreyButton,
                      borderColor: kGreyButtonBorder,
                      trailing: S.of(context).singInFaceBook,
                      icon: Icons.facebook),
                  CustomListTile(
                    backgroundColor: kGreyButton,
                    borderColor: kGreyButtonBorder,
                    trailing: S.of(context).singInGoogle,
                    icon: CustomGoogleIcon.google,
                  ),
                  CustomListTile(
                      backgroundColor: kGreyButton,
                      borderColor: kGreyButtonBorder,
                      trailing: S.of(context).singInApple,
                      icon: Icons.apple),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
