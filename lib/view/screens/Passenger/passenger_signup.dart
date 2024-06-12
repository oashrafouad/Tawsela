import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/models/imageCubit/image_cubit.dart';
import 'package:tawsela_app/services/signUp.dart';
import 'package:tawsela_app/utilities.dart';
import 'package:tawsela_app/view/screens/Passenger/welcome_page.dart';
import 'package:tawsela_app/view/screens/Passenger/passenger_main_screen.dart';

import 'package:tawsela_app/view/widgets/custom_button.dart';
import 'package:tawsela_app/view/widgets/custom_text_button.dart';

import 'package:tawsela_app/view/widgets/custom_text_field.dart';

String firstName = '';
String lastName = '';
String? email;
enum LoadingStatus { idle, inProgress, completed, error } // Flag to track loading status
String HUDError = '';

class PassengerSignUpPage extends StatefulWidget {
  const PassengerSignUpPage({super.key});
  static String id = 'PassengerSignUpPage';

  @override
  _PassengerSignUpPageState createState() => _PassengerSignUpPageState();
}

class _PassengerSignUpPageState extends State<PassengerSignUpPage> {
  LoadingStatus _loadingStatus = LoadingStatus.idle;

  @override
  Widget build(BuildContext context) {
    final imageCubit = context.read<ImageCubit>();
    SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom);
    SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.custom);
    SVProgressHUD.setMinimumDismissTimeInterval(1.5);
    SVProgressHUD.setMaximumDismissTimeInterval(1.5);
    SVProgressHUD.setBackgroundLayerColor(Colors.black.withOpacity(0.4));
    SVProgressHUD.setHapticsEnabled(true);
    SVProgressHUD.setRingThickness(4);

    switch (_loadingStatus) {
      case LoadingStatus.idle:
        SVProgressHUD.dismiss();
      case LoadingStatus.inProgress:
        SVProgressHUD.show();
      case LoadingStatus.completed:
        SVProgressHUD.showSuccess(status: "تم تسجيل الدخول");
        _loadingStatus = LoadingStatus.idle; // Reset status to idle after success
      case LoadingStatus.error:
        SVProgressHUD.showError(status: "حدث خطأ، الرجاء المحاولة مرة اخرى\n$HUDError");
        _loadingStatus = LoadingStatus.idle; // Reset status to idle after error
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kGreenBigButtons),
      ),
      body: ListView(
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
                  onChanged: (data) => email = data,
                  textAlign: isArabic() ? TextAlign.end : TextAlign.start,
                  width: 284,
                  height: 46,
                  titleAbove: S.of(context).email,
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
                onTap: () {
                  if (kDebugMode || kIsWeb) { // TODO: Remove this block when the API is ready
                    Navigator.pushNamed(context, PassengerMainScreen.id);
                  } else {
                  setState(() {
                    _loadingStatus = LoadingStatus.inProgress; // Set status to inProgress when sign-up is initiated
                  });
                    // Call the sign-up API
                    ApiService.signUp(
                      phoneNumber: phoneNumber,
                      fname: firstName,
                      lname: lastName,
                      Email_ID: null,
                      password: "passwordhkfdjhe",
                    ).then((_) {
                      setState(() {
                        _loadingStatus = LoadingStatus
                            .completed; // Set status to completed when sign-up is successful
                      });
                      // Add delay of 1.5 seconds to match the duration of the success HUD
                      Future.delayed(const Duration(milliseconds: 1500)).then((
                          value) {
                        // Then navigate to the main screen
                        Navigator.pushNamed(context, PassengerMainScreen.id);
                      });
                    }).catchError((error) {
                      // Handle error
                      setState(() {
                        _loadingStatus = LoadingStatus
                            .error; // Set status to error when sign-up fails
                        HUDError = error.toString();
                      });
                      print('Failed to sign-up: $error');
                    });
                  }
                },
              )
            ],
          ),
    );
  }
}