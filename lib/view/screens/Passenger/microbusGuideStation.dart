import 'package:flutter/material.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/helper/checkLang.dart';
import 'package:tawsela_app/view/widgets/customCircleContainer.dart';
import 'package:tawsela_app/view/widgets/palceItemBuilder.dart';

class MicrobusGuideStation extends StatelessWidget {
  MicrobusGuideStation({required this.color, required this.line, super.key});
  Color color;
  String line;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).MicrobusGuideStationAppBarTitle,
              style: TextStyle(
                  fontFamily: font, fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 8),
            CustomCircleContainer(
              line: line,
              color: color,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Stack(children: [
        Padding(
          padding: EdgeInsets.only(
            top: 16,
              right: isArabic() ? 20 : 0, left: isArabic() ? 0 : 28),
          child: Container(
            width: 4,
            height: double.infinity,
            color: color,
            transform: Matrix4.rotationY(3.14159), // Rotate 180 degrees
          ),
        ),
        ListView(children: [
          for (int i = 0; i < 20; i++)
            PlacesItemBuilder(
              color: color,
              place: S.of(context).hawatam
            ),
        ]),
      ]),
    );
  }
}
