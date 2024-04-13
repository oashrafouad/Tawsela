import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tawsela_app/generated/l10n.dart';

import '../../constants.dart';

class WeirdAppBar extends StatelessWidget {
   WeirdAppBar({required this.icon,required this.hintText,super.key});
  IconData icon;
  String hintText;
  @override
  Widget build(BuildContext context) {
    return  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon,color: Colors.green,),
                  SizedBox(width: 8,),
                  SearchBar(
            onSubmitted: (value) {
              print(value);
            },
            constraints: const BoxConstraints(maxWidth: 240),
            //leading: const Icon(Icons.search),
            hintText: hintText,//S.of(context).whereUwantoGo,
            hintStyle: MaterialStateProperty.all(TextStyle(
                fontFamily: font, fontSize: 16, fontWeight: FontWeight.w400)),
            padding: const MaterialStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 8.0, vertical: 4)),
            backgroundColor: MaterialStateProperty.all(Colors.white),
          ),
                ],
              ),
            ],
          );
  }
}