import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/loading_status_handler.dart';
import 'package:tawsela_app/models/bloc_models/imageCubit/image_cubit.dart';
import 'package:tawsela_app/services/signUp.dart';
import 'package:tawsela_app/utilities.dart';
import 'package:tawsela_app/view/screens/Passenger/passenger_main_screen.dart';

import 'package:tawsela_app/view/widgets/custom_button.dart';
import 'package:tawsela_app/view/widgets/custom_text_button.dart';

import 'package:tawsela_app/view/widgets/custom_text_field.dart';

String firstName = '';
String lastName = '';
String? email;

class PassengerSignUpPage extends StatefulWidget {
  const PassengerSignUpPage({super.key});
  static String id = 'PassengerSignUpPage';

  @override
  _PassengerSignUpPageState createState() => _PassengerSignUpPageState();
}

class _PassengerSignUpPageState extends State<PassengerSignUpPage> {

  @override
  Widget build(BuildContext context) {
    // print(currentUser?.phoneNumber);

    GlobalKey<FormState> formKey = GlobalKey();

    final imageCubit = context.read<ImageCubit>();

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kGreenBigButtons),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60),
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
                useValidator: false,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.start,
                onChanged: (data) => email = data,
                width: 284,
                height: 46,
                titleAbove: S.of(context).email,
                keyboardType: TextInputType.emailAddress,
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


                            showImagePicker(context, (Image newImage) {
                              imageCubit.setAvatarImg(newImage);
                            });
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
              onTap: () async {
                if (formKey.currentState!.validate()) {
                Navigator.pushNamed(context, PassengerMainScreen.id);
                  // Call the sign-up API
                  // TODO: Remove this comment when the API is ready
                  // ApiService.signUp(
                  //   phoneNumber: "1104149210",
                  //   fname: firstName,
                  //   lname: lastName,
                  //   Email_ID: null,
                  //   password: "passwordhkfdjhe",
                  // ).then((_)  {
                  //   LoadingStatusHandler.completeLoadingWithText("تم التسجيل").then((_) {
                  //     // Then navigate to the main screen
                  //     Navigator.pushNamed(context, PassengerMainScreen.id);
                  //     });
                  // }).catchError((error) {
                  //   // Handle error
                  //     LoadingStatusHandler.errorLoading(error.toString());
                  //   print('Failed to sign-up: $error');
                  // });
                } else {
                  String remove_en = "Fill in", remove_ar = "املأ";
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Center(
                          child: Text(
                        "${S.of(context).PleaseEnter}${(S.of(context).passengerSignUpTitle).replaceFirst(isArabic() ? remove_ar : remove_en, "")}",
                        style: const TextStyle(fontFamily: font),
                      )),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
