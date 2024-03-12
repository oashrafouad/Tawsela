import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/view/widgets/favPlacesItemBuilder.dart';

class DriverPickupLocation extends StatelessWidget {
  const DriverPickupLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: SearchBar(
            onSubmitted: (value) {
              print(value);
            },
            constraints: const BoxConstraints(maxWidth: 400),
            leading: const Icon(Icons.search),
            hintText: S.of(context).specifyASpecificLocationToPickUpPassengers,
            hintStyle: MaterialStateProperty.all(TextStyle(
                fontFamily: font, fontSize: 16, fontWeight: FontWeight.w400)),
            padding: const MaterialStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 8.0, vertical: 4)),
            backgroundColor: MaterialStateProperty.all(Colors.white),
          ),
        ),
      ),
      body: Column(
        
        crossAxisAlignment: CrossAxisAlignment.start
        ,children: [

        
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const Icon(Icons.map_outlined),
              const SizedBox(
                width: 16,
              ),
              Text(
                S.of(context).chooseOnMap,
                style: TextStyle(
                    fontFamily: font,
                    fontSize: 11,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),

        ),
        

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16),
          child: Text(
                  S.of(context).favourite,
                  style: TextStyle(
                      fontFamily: font,
                      fontSize: 10,
                      color: const Color(0xff6B6B6B),
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
            SizedBox(height: 16,),
            Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16),
          child: Text(
                  S.of(context).recentlyVisited,
                  style: TextStyle(
                      fontFamily: font,
                      fontSize: 10,
                      color: const Color(0xff6B6B6B),
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
    );
  }
}
