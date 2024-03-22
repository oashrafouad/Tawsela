import 'package:flutter/material.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/helper/displayLines.dart';
import 'package:tawsela_app/helper/randomColorsGenerator.dart';
import 'package:tawsela_app/view/screens/Passenger/microbusGuideStation.dart';
import 'package:tawsela_app/view/screens/Passenger/passengerProfile.dart';
import 'package:tawsela_app/view/widgets/customCircleContainer.dart';
import 'package:tawsela_app/view/widgets/customTextButton.dart';

import 'package:tawsela_app/view/widgets/favPlacesItemBuilder.dart';

Color randomColor = Colors.black;

class PassengerMainScreen extends StatelessWidget {
  const PassengerMainScreen({super.key});
  static String id='passengerMainScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: SizedBox(
                    
                    child: Image.asset(
                        fit: BoxFit.fill, 'assets/images/header.jpg'),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, PassengerProfile.id);
                    // print('goto to Profile passenger');
                  },
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                AssetImage('assets/images/avatar.jpg'),
                            backgroundColor: Color.fromARGB(255, 44, 40, 40)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 120.0),
                  child: Center(
                    child: SearchBar(
                      onSubmitted: (value) {
                      
                        print(value);
                      },
                      constraints: const BoxConstraints(maxWidth: 300),
                      leading: const Icon(Icons.search),
                      hintText: S.of(context).whereUwantoGo,
                      hintStyle: MaterialStateProperty.all(TextStyle(
                          fontFamily: font,
                          fontSize: 16,
                          fontWeight: FontWeight.w400)),
                      padding: const MaterialStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8)),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
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
                    style: TextStyle(
                        color: const Color(0xff303030),
                        fontFamily: font,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                  CustomTextButton(
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
                    style: TextStyle(
                        color: const Color(0xff303030),
                        fontFamily: font,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                  CustomTextButton(
                    icon: Icons.arrow_forward_ios,
                    text: S.of(context).showAll,
                    fontSize: 12,
                  )
                ],
              ),
            ),
            //SizedBox(height: 8,),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (int i = 1; i <= 17; i++)
                    if (i >= 1 && i < 10 || i == 11 || i == 15 || i == 17)
                      Padding( 
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CustomCircleContainer(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MicrobusGuideStation(
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
    );
  }
}
