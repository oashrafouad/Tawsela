import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/models/imageCubit/image_cubit.dart';

import 'package:tawsela_app/utilities.dart';
import 'package:tawsela_app/view/screens/Passenger/microbusGuideStation.dart';
import 'package:tawsela_app/view/screens/Passenger/passengerPickupLocation.dart';
import 'package:tawsela_app/view/screens/Passenger/passengerProfile.dart';

import 'package:tawsela_app/view/widgets/customCircleContainer.dart';
import 'package:tawsela_app/view/widgets/customTextButton.dart';

import 'package:tawsela_app/view/widgets/favPlacesItemBuilder.dart';

Color randomColor = Colors.black;

class PassengerMainScreen extends StatelessWidget {
  const PassengerMainScreen({super.key});

  static String id = 'passengerMainScreen';

  @override
  Widget build(BuildContext context) {

    final imageState = context.watch<ImageCubit>().state;
    return PopScope(
      // TODO: set this value to false in production!
      canPop: true,
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  SizedBox(
                    child: Image.asset(
                      'assets/images/header.jpg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 205,
                    ),
                  ),
                  Material( // to enable splash effect on image
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 16),
                      child: Ink.image(
                        image: imageState.avatarImg.image,
                        width: 50,
                        height: 50,
                        child: InkWell(
                          splashFactory: splashEffect,
                          customBorder: const CircleBorder(), // make splash effect circular
                          onTap: () {
                            Navigator.pushNamed(context, PassengerProfile.id);
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 120.0),
                    child: Center(
                      child: TextField(
                        textInputAction: TextInputAction.search,
                        readOnly: true, // prevent user from entering input as tapping will go to another screen anyways
                        onTap: () {
                          Navigator.pushNamed(
                              context, PassengerPickupLocationPage.id);
                        },
                        decoration: InputDecoration(
                          constraints: const BoxConstraints(maxWidth: 300),
                          hintText: S.of(context).whereUwantoGo,
                          hintStyle: const TextStyle(
                              fontFamily: font,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                          prefixIcon: const Icon(Icons.search),
                          contentPadding: const EdgeInsets.symmetric(vertical: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide.none
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).favPlaces,
                      style: const TextStyle(
                          color: kGreyFont,
                          fontFamily: font,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                    CustomTextButton(
                      onTap: () {
                        // TODO: implement add new fav place
                      },
                      icon: Icons.add,
                      text: S.of(context).add,
                      fontSize: 12,
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    for (int i = 0; i < 5; i++)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FavPlacesItemBuilder(
                            title: S.of(context).home,
                            subTitle: S.of(context).clickSelectThisLocation,
                            icon: Icons.home,
                          ),
                          const Divider(
                            thickness: 1,
                          )
                        ],
                      )
                  ],
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).microbusesLinesGuide,
                      style: const TextStyle(
                          color: kGreyFont,
                          fontFamily: font,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (int i = 1; i <= 17; i++)
                      if (i >= 1 && i < 10 ||
                          i == 11 ||
                          i == 13 ||
                          i == 15 ||
                          i == 17)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CustomCircleContainer(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MicrobusGuideStationPage(
                                          line: displayLines(i),
                                          color: randomColorsGenerator(),
                                        )),
                              );
                            },
                            color: randomColorsGenerator(),
                            line: displayLines(i),
                          ),
                        )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}