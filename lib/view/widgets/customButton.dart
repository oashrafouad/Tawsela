
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tawsela_app/constants.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    this.onTap,
    this.text = '',
    this.buttonColor = const Color(0xff28AA45),
    this.textColor = Colors.white,
    this.width,
    this.height,
    this.radius = 10,
    this.fontSize = 22,
    this.fontWeight = FontWeight.w400,
   
  });

  String text;
  Function? onTap;
  Color buttonColor, textColor;
  double ?height, width; double radius, fontSize;
  FontWeight fontWeight;
  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: buttonColor
          ),
          child: OutlinedButton(
            style: ButtonStyle(
                side: MaterialStateProperty.all(BorderSide(color: buttonColor)),
                backgroundColor: MaterialStateProperty.all(buttonColor)),
            onPressed: () {
              //print('a7aaa bgd');
              onTap != null ? () => onTap!() : null;
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 85,vertical: 12),
              child: Text(
                text,
                style: TextStyle(
                    fontFamily: font,
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: textColor),
              
              ),
            ),
          ),
        ),
      ],
    );
  }
}
