import 'package:flutter/material.dart';

import 'package:tawsela_app/constants.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    @required this.onTap,
    this.text = '',
    this.buttonColor = kGreenBigButtons,
    this.textColor = Colors.white,
    this.width = 284,
    this.height = 54,
    this.radius = 20,
    this.fontSize = 22,
    this.fontWeight = FontWeight.w400,
  });

  String text;
  Function? onTap;
  Color buttonColor, textColor;
  double height, width;
  double radius, fontSize;
  FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: () {
          if (onTap != null) {
          onTap!();
        }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: kGreenBigButtons,
          shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(radius),
  ),
          //maximumSize: Size(width, height)
        ),
        child: Text(
          text,
          style: TextStyle(
              fontFamily: font,
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: textColor),
        ),
      ),
    );
  }
}
