import 'package:flutter/material.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';

import 'package:tawsela_app/view/screens/Passenger/microbus_suggested_lines.dart';
import 'package:tawsela_app/view/widgets/fav_places_item_builder.dart';

class PassengerPickupLocationPage extends StatelessWidget {
  const PassengerPickupLocationPage({super.key});
  static String id = 'PassengerPickupLocationPage';

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
        ),
      ),
      child: GestureDetector(
        onTap: () { // To dismiss keyboard when tapping anywhere outside search bar
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: AppBar(

            // iconTheme: const IconThemeData(color: kGreenBigButtons),
            surfaceTintColor: noColor,
            // toolbarHeight: 64,
            centerTitle: true,
            title: SearchBar(
              // auto activate search bar
              autoFocus: true,
              // disable keyboard when tapping outside the search bar
              onSubmitted: (value) {
                print(value);
              },
              elevation: WidgetStateProperty.all(0),
              constraints: const BoxConstraints(maxWidth: 400),
              leading: const Icon(Icons.search),
              hintText: S.of(context).whereUwantoGo,
              textStyle: WidgetStateProperty.all(const TextStyle(
                  fontFamily: font,
                  fontSize: 13,
                  fontWeight: FontWeight.w400)),
              hintStyle: WidgetStateProperty.all(const TextStyle(
                  fontFamily: font, fontSize: 13, fontWeight: FontWeight.w400)),
              padding: const WidgetStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 12.0, vertical: 6)),
              backgroundColor: WidgetStateProperty.all(Colors.grey[200]),
            ),
          ),
          body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  InkWell(
                      onTap: () => Navigator.pushNamed(
                          context, MicrobusSuggestedLinesPage.id),
                      child: const Icon(Icons.map_outlined)),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    S.of(context).chooseOnMap,
                    style: const TextStyle(
                        fontFamily: font,
                        fontSize: 11,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: Text(
                S.of(context).favourite,
                style: const TextStyle(
                    fontFamily: font,
                    fontSize: 10,
                    color: Color(0xff6B6B6B),
                    fontWeight: FontWeight.w400),
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
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: Text(
                S.of(context).recentlyVisited,
                style: const TextStyle(
                    fontFamily: font,
                    fontSize: 10,
                    color: Color(0xff6B6B6B),
                    fontWeight: FontWeight.w400),
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
                          icon: Icons.location_on_outlined,
                        ),
                        const Divider(
                          thickness: 1,
                        )
                      ],
                    )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
