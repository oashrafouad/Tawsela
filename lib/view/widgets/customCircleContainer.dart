import 'package:flutter/material.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/view/screens/Passenger/passengerMainScreen.dart';

class CustomCircleContainer extends StatelessWidget {
  CustomCircleContainer(
      {super.key, this.line = '', this.color = Colors.orange,this.onTap});

  String line;
  Color color;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: color,
          width: 4,
        ),
        shape: BoxShape.circle,
      ),
      child: InkWell(
        focusColor: noColor,
        splashColor: noColor,
        hoverColor: noColor,
        highlightColor: noColor,
       
        onTap: onTap,
        child: Center(
          child: Text(
            line,
            style: TextStyle(
              fontFamily: font,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xff484848),
            ),
          ),
        ),
      ),
    );
  }
}
