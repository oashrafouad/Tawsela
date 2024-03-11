import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/view/widgets/customButton.dart';
import 'package:tawsela_app/view/widgets/customListTile.dart';
import 'package:tawsela_app/view/widgets/customTextField.dart';
import 'package:tawsela_app/constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

//rerverse the number phone

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  S.of(context).title,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                    fontFamily: font,
                  ),
                ),
              ),
              Text(
                S.of(context).appName,
                style: TextStyle(
                  color: const Color(0xff339949),
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
                    style: TextStyle(
                      fontFamily: font,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                    //t//extScaleFactor: 3,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextFormField(
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
                      padding:  EdgeInsets.only(top: 24.0),
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
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: CustomButton(
              // height: 54,
              // width: 284,
              radius: 10,
              buttonColor: kGreenButtons,
              textColor: Colors.white,
              text: S.of(context).continuee,
            ),
          ),
          // Divider(thickness: 3,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 1.5,
                width: 150,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(S.of(context).or),
              ),
              Container(
                height: 1.5,
                width: 150,
                color: Colors.grey,
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
                      height: 54,
                      width: 284,
                      backgroundColor: const Color(0xffF2F2F2),
                      borderColor: const Color(0xff757775),
                      trailing:
                          S.of(context).singInFaceBook, //'سجل بحساب فيسبوك',
                      icon: Icons.facebook),
                  CustomListTile(
                      height: 54,
                      width: 284,
                      backgroundColor: const Color(0xffF2F2F2),
                      borderColor: const Color(0xff757775),
                      trailing: S.of(context).singInApple, //'سجل بحساب آبل ',
                      icon: Icons.apple),
                  CustomListTile(
                      height: 54,
                      width: 284,
                      backgroundColor: const Color(0xffF2F2F2),
                      borderColor: const Color(0xff757775),
                      trailing:
                          S.of(context).singInGoogle, //'سجل بحساب جوجل ',
                      icon: Icons.g_mobiledata),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
