// import 'package:flutter/material.dart';
// import 'package:tawsela_app/constants.dart';
// import 'package:tawsela_app/generated/l10n.dart';
// import 'package:tawsela_app/view/widgets/customTextField.dart';


// class customTextFieldWithTitleAbove extends StatelessWidget {
//   const customTextFieldWithTitleAbove({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//               padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(right: 0, bottom: 8),
//                     child: Text(
//                       titleAbove,
//                     //  style: TextStyle(
//                           fontFamily: font,
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           color: const Color(0xff444444)),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       CustomTextFormField(
//                         height: 46,
//                         width: 213,
//                         hintText: "123456789",
//                         keyboardType: TextInputType.phone,
//                       ),
//                       const SizedBox(
//                         width: 8,
//                       ),
//                       const SizedBox(
//                           height: 20,
//                           width: 29,
//                           child: Text(
//                             '20+',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w400, fontSize: 16),
//                           )),
//                       const SizedBox(
//                         width: 8,
//                       ),
//                       SizedBox(
//                           height: 23,
//                           width: 23,
//                           child: Image.asset('assets/images/flag.png')),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//   }
// }