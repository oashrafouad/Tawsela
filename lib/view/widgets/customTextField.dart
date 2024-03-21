import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key,
      this.onChanged,
      this.hintText,
      this.labelText,
      required this.width,
      required this.height,
      this.titleAbove = '',
      this.keyboardType,
      
      this.radius=10});
  String? hintText;
  String? labelText;
  double width, height,radius;
  String titleAbove;

  TextInputType? keyboardType;
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 0, bottom: 8),
          child: Text(
            titleAbove,
            style: TextStyle(
                fontFamily: font,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xff444444)),
          ),
        ),
        SizedBox(
          height: height,
          width: width,
          child: TextFormField(
             
            keyboardType: keyboardType,
            style: const TextStyle(color: Colors.black),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Field is Required';
              }
            },
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey),
              border:  OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(radius))),
              enabledBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius)),
                  borderSide: const BorderSide(color: Color(0xffDDDDDD))),
              focusedBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.green)),
            ),
          ),
        )
      ],
    );
  }
}