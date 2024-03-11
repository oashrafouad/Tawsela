import 'package:flutter/material.dart';
import 'package:tawsela_app/constants.dart';

class CustomTextButton extends StatelessWidget {
  CustomTextButton({
    super.key,
    this.buttonColor = const Color(0xffB3EABF),
    this.textColor = const Color(0xff007119),
    this.iconColor = const Color(0xff007119),
    this.text = '',
    this.radius = 12,
    this.icon,
    this.iconSize = 15,
    this.fontSize = 10,
    this.fontWeight = FontWeight.w500,
    this.paddingHorzin=8,
    this.paddingVerti=2
  });
  String text;
  Color buttonColor, textColor, iconColor;
  double radius, iconSize, fontSize,paddingHorzin,paddingVerti;
  IconData? icon;
  FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return (Container(
        decoration: BoxDecoration(
          border: Border.all(color: textColor, width: 1),
          color: buttonColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: InkWell(
          splashColor: textColor,
          borderRadius: BorderRadius.circular(radius),
          onTap: () {},
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: paddingHorzin, vertical: paddingVerti),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                      fontFamily: font,
                      color: textColor,
                      fontSize: fontSize,
                      fontWeight: fontWeight),
                ),
                SizedBox(width: 8,),
               
                Icon(
                  size: iconSize,
                  icon,
                  color: iconColor,
                ),
              ],
            ),
          ),
        )));
  }
}
