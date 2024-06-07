import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/utilities.dart';

class CustomButtomSheet_imgPick extends StatelessWidget {
  const CustomButtomSheet_imgPick({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 5.2,
          margin: const EdgeInsets.only(top: 8.0),
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              bottomSheetBuilderIcon(
                  source: ImageSource.camera,
                  icon: Icons.photo_camera_outlined,
                  text: S.of(context).camera),
              bottomSheetBuilderIcon(
                  source: ImageSource.gallery,
                  icon: Icons.image_outlined,
                  text: S.of(context).gallery),
            ],
          )),
    );
  }
}

class bottomSheetBuilderIcon extends StatelessWidget {
  bottomSheetBuilderIcon(
      {required this.source,
      required this.icon,
      required this.text,
      super.key});
  ImageSource source;
  IconData icon;
  String text;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFB3EABF),
            ),
            height: 75,
            width: 75,
            child: Icon(
              icon,
              size: 35.0,
              color: kGreenFont,
            ),
          ),
          const SizedBox(height: 12.0),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 16, color: kGreyFontDark, fontFamily: font),
          )
        ],
      ),
      onTap: () {
        imagePick(source);
        Navigator.pop(context);
      },
    ));
  }
}
