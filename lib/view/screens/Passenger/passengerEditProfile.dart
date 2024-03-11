import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/helper/checkLang.dart';
import 'package:tawsela_app/view/screens/Passenger/passengerProfile.dart';
import 'package:tawsela_app/view/widgets/customButton.dart';
import 'package:tawsela_app/view/widgets/customTextField.dart';


class PassengerEditProfile extends StatelessWidget {
  const PassengerEditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          S.of(context).editProfile,
          style: TextStyle(
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
                    top: 16,
                    right: isArabic() ? 28 : 0,
                    left: isArabic() ? 0 : 28),
                child: Text(
                  S.of(context).personalImage,
                  style: TextStyle(
                      fontFamily: font,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
           Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Center(
              child: Stack(children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage:  AssetImage('assets/images/avatar.jpg'),
                ),
                Positioned(
                    top: 70,
                    right: 35,
                    child: InkWell(
                      onTap: (){print('pressed');},
                      child: Text(
                        S.of(context).edit,
                        style: TextStyle(
                          fontFamily: font,
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                            color: const Color(0xffF6F6F6)),
                      ),
                    )),
              ]),
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
                  height: 16,
                ),
                Center(
                  child: CustomTextFormField(
                    width: 284,
                    height: 46,
                    titleAbove: S.of(context).email,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          CustomButton(
            onTap: () {
              print("Hussssssh");
              // Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (context) => PassengerProfile()),
              //           );
              // //to passengerProfile
            },
            radius: 6,
            width: 284,
            height: 54,
            text: S.of(context).save,
          )
        ],
      ),
    );
  }
}
