import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/utilities.dart';

class CustomTextFormField extends StatelessWidget {

  CustomTextFormField({
    super.key,
    this.onChanged,
    this.hintText,
    this.labelText,
    this.textDirection,
    required this.width,
    required this.height,
    this.titleAbove = '',
    this.keyboardType,
    this.radius = 10,
    this.maxLength,
    this.inputFormatters
  });

  String? hintText;
  String? labelText;
  double width, height, radius;
  String titleAbove;
  int? maxLength;
  List<TextInputFormatter>? inputFormatters;
  int? maxlines;
  TextInputType? keyboardType;
  TextDirection? textDirection;
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
            style: const TextStyle(color: Colors.black),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Field is Required';
              }
            },
            onChanged: onChanged,
            
            decoration: InputDecoration(
              hintText: hintText,
            
              counterText: "", // to prevent counter text from appearing below the text field
              contentPadding: EdgeInsets.symmetric(vertical: 4,horizontal: 4),

              //labelText: S().phoneNum,
              // alignLabelWithHint: true,
              hintStyle: const TextStyle(color: kGreyFontLight),
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
