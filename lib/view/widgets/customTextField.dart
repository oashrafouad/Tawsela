import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tawsela_app/constants.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key,
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
      this.inputFormatters});

  String? hintText;
  String? labelText;
  double width, height, radius;
  String titleAbove;
  int? maxLength;
  List<TextInputFormatter>? inputFormatters;
  int? maxlines;
  TextInputType? keyboardType;
  TextAlign textAlign;
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
            style: const TextStyle(
                fontFamily: font,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: kGreyFont),
          ),
        ),
        SizedBox(
          height: height,
          width: width,
          child: TextFormField(
            maxLines: maxLength,
            keyboardType: keyboardType,
            style: const TextStyle(color: Colors.black, fontFamily: font),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Field is Required';
              }
            },
            textAlign: textAlign,
            cursorColor: kGreenBigButtons,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              counterText: '',
              contentPadding:
                  const EdgeInsets.only(right: 4, left: 4, top: 16, bottom: 4),
              hintStyle:
                  const TextStyle(color: kGreyFontLight, fontFamily: font),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(radius))),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(radius)),
                  borderSide: const BorderSide(color: kGreyBorderLight)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: kGreenButtonBorder)),
            ),
            maxLength: maxLength,
            inputFormatters: inputFormatters,
          ),
        )
      ],
    );
  }
}
