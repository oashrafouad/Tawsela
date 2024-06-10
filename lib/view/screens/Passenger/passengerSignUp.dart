import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/models/imageCubit/image_cubit.dart';
import 'package:tawsela_app/services/signUp.dart';
import 'package:tawsela_app/utilities.dart';
import 'package:tawsela_app/view/screens/Passenger/WelcomePage.dart';
import 'package:tawsela_app/view/screens/Passenger/passengerMainScreen.dart';
import 'package:tawsela_app/view/widgets/customButton.dart';
import 'package:tawsela_app/view/widgets/customTextButton.dart';
import 'package:tawsela_app/view/widgets/customTextField.dart';

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
  bool _loading = false; // Flag to track loading state

  @override
  Widget build(BuildContext context) {
    final imageCubit = context.read<ImageCubit>();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kGreenBigButtons),
      ),
      body: _loading
          ? const Center(
              child: const CircularProgressIndicator(
                color: kGreenBigButtons,
                backgroundColor: Colors.white54,
              ),
            )
          : ListView(
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
                    setState(() {
                      _loading = true; // Set loading to true when sign-up is initiated
                    });
                    ApiService.signUp(
                      phoneNumber:phoneNumber ,
                      fname: firstName,
                      lname: lastName,
                      Email_ID: null,
                      password: "passwordhkfdjhe",
                    ).then((_) {
                      // When sign-up is successful, navigate to the main screen
                      Navigator.pushNamed(context, PassengerMainScreen.id);
                    }).catchError((error) {
                      // Handle error
                      print('Sign-up error: $error');
                    }).whenComplete(() {
                      setState(() {
                        _loading = false; // Set loading to false when sign-up completes (successful or failed)
                      });
                    });
                  },
                )
              ],
            ),
    );
  }
}
