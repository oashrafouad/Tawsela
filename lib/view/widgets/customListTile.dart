import 'package:flutter/material.dart';


class CustomListTile extends StatelessWidget {
  CustomListTile(
      {super.key,
      this.trailing = '',
      required this.icon,
      this.title = '',
      this.borderRadius = 12,
      this.color = Colors.white,
      this.titleColor = Colors.black,
      this.trailingColor = Colors.black,
      this.height = 54,
      this.width = 300,
      this.iconSize = 35,
      this.backgroundColor = Colors.white,
      this.borderColor = Colors.black,
      this.fontWeight = FontWeight.w400,
      this.fontSize = 20,
      this.iconColor = Colors.black});
  FontWeight fontWeight;
  IconData icon;
  String trailing, title;
  double iconSize, height, width, borderRadius, fontSize;
  Color iconColor,
      color,
      titleColor,
      trailingColor,
      backgroundColor,
      borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: backgroundColor,
          border: Border.all(color: borderColor, width: 1.5)),
      child: InkWell(
        child: Container(
          width: width,
          height: height,
          child:
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                children: [
                            Text(
                trailing,
                style: TextStyle(
                    color: trailingColor,
                    fontWeight: fontWeight,
                    fontSize: fontSize,
                    fontFamily: 'Alexandria'),
                            ),
                            Icon(
                icon,
                size: iconSize,
                            ),
                          ]),
              ),
        ),
      ),
    );
  }
}
