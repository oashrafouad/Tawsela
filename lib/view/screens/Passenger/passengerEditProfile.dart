import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/models/imageCubit/image_cubit.dart';
import 'package:tawsela_app/utilities.dart';
import 'package:tawsela_app/view/screens/Driver/driverSignUp.dart';
import 'package:tawsela_app/view/screens/Passenger/passengerSignUp.dart';
import 'package:tawsela_app/view/widgets/customButton.dart';
import 'package:tawsela_app/view/widgets/customTextField.dart';

class PassengerEditProfile extends StatelessWidget {
  const PassengerEditProfile({super.key});
  static String id = 'passengerEditProfilePage';

  @override
  Widget build(BuildContext context) {
    final imageCubit = context.read<ImageCubit>();
    final imageState = context.watch<ImageCubit>().state;
    return Scaffold(

      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.green),
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
                    top: 16,
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
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Center(
              child: Stack(children: [
                CircleAvatar(
                    radius: 70,
                    backgroundImage:  imageState.avatarImg.image,
                    backgroundColor: kGreyFont),
                Positioned(
                    top: 100,
                    right: 42,
                    child: InkWell(
                      onTap: () {
                        showImagePicker(context, (Image newImage) {
                                imageCubit.setAvatarImg(newImage);
                              });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: noColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 99, 96, 96)
                                  .withOpacity(0.7),
                              spreadRadius: 10,
                              blurRadius: 24,
                              offset: const Offset(
                                  3, 0), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Text(
                          S.of(context).edit,
                          style: const TextStyle(
                              fontFamily: font,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: Color(0xffF6F6F6)),
                        ),
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
                      textAlign: TextAlign.end,
                      titleAbove: S.of(context).phoneNum,
                      height: 46,
                      width: 213,
                      maxLength: 10,
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
                    textAlign: TextAlign.end,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: CustomButton(
              onTap: () {
                Navigator.pop(context);
              },
              text: S.of(context).save,
            ),
          )
        ],
      ),
    );
  }
}
