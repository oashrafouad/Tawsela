import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tawsela_app/constants.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final double width;
  final double height;
  final double radius;
  final String titleAbove;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final TextInputType? keyboardType;
  final TextAlign textAlign;
  final Function(String)? onChanged;
   
   final TextEditingController? controller;

  const CustomTextFormField({
    super.key,
    this.onChanged,
    this.hintText,
    this.labelText,
    this.textAlign = TextAlign.start,
    required this.width,
    required this.height,
    this.titleAbove = '',
    this.keyboardType,
    this.radius = 10,
    this.maxLength,
    this.inputFormatters,
    this.maxLines,
    this.controller,
   
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (titleAbove.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              titleAbove,
              style: const TextStyle(
                fontFamily: font,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: kGreyFont,
              ),
            ),
          ),
        SizedBox(
          height: height,
          width: width,
          child: TextFormField(
            maxLines: maxLines ?? 1,
            keyboardType: keyboardType,
            style: const TextStyle(color: Colors.black, fontFamily: font, fontSize: 13),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Field is Required';
              }
              return null;
            },
            textAlign: textAlign,
            cursorColor: kGreenBigButtons,
            onChanged: onChanged,
            
            decoration: InputDecoration(
              hintText: hintText,
              labelText: labelText,
              counterText: '',
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 4.0,
                vertical: 16.0,
              ),
              hintStyle: const TextStyle(color: kGreyFontLight, fontFamily: font),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius)),
                borderSide: const BorderSide(color: kGreyBorderLight),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: kGreenButtonBorder),
              ),
            ),
            maxLength: maxLength,
            inputFormatters: inputFormatters,
          ),
        ),
      ],
    );
  }
}
