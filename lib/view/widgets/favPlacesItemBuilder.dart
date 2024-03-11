import 'package:flutter/material.dart';
import 'package:tawsela_app/constants.dart';

class FavPlacesItemBuilder extends StatelessWidget {
  FavPlacesItemBuilder(
      {required this.title,
      required this.subTitle,
      required this.icon,
      super.key});
  String title, subTitle;
  IconData icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color(0xff339949),
        size: 32,
      ),
      title: Text(
        title,
        style: TextStyle(
            color: const Color(0xff303030),
            fontFamily: font,
            fontSize: 14,
            fontWeight: FontWeight.w400),
      ),
      subtitle: Text(
        subTitle,
        style: TextStyle(
            color: const Color(0xff989898),
            fontFamily: font,
            fontSize: 9,
            fontWeight: FontWeight.w400),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
