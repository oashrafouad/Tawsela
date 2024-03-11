import 'package:flutter/material.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/helper/checkLang.dart';
import 'package:tawsela_app/view/widgets/customButton.dart';
import 'package:tawsela_app/view/widgets/customTextField.dart';

class smsVerfication extends StatelessWidget {
  const smsVerfication({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Container(
                  height: 40,
                  width: 301,
                  child: Text(
                    S.of(context).smsVerificationScreenTitle,
                    style: TextStyle(
                      fontFamily: font,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  )),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextFormField(
                width: 284,
                height: 46,
                titleAbove: S.of(context).verifyCode,
                keyboardType: TextInputType.phone,
              ),
              Padding(
                padding:  EdgeInsets.only(left:isArabic()? 32:0,right: isArabic()? 0:32, top: 8),
                child: SizedBox(
                  width: 320,
                //height: 46,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        S.of(context).sendCodeAgain,
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: const Color(0xff28AA45),
                            fontFamily: font,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff28AA45)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: CustomButton(
                width: 284,
                height: 54,
                buttonColor: kGreenButtons,
                text: S.of(context).continuee),
          )
        ],
      ),
    );
  }
}
