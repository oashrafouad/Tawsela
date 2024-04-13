import 'package:flutter/material.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/view/widgets/weirdAppBar.dart';

class MicrobusSuggestedLinesPage extends StatelessWidget {
  const MicrobusSuggestedLinesPage({super.key});
  static String id = 'MicrobusSuggestedLinesPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kGreenBigButtons),
      ),
      // body: Stack(
      //   //fit: StackFit.expand,
      //   children: [
      //     Image.asset(
      //       'assets/images/map.png',
      //       fit: BoxFit.fill,
      //     ),
      //     ClipRRect(
      //       borderRadius: const BorderRadius.only(
      //           bottomLeft: Radius.circular(32),
      //           bottomRight: Radius.circular(32)),
      //       child: Container(
      //         height: MediaQuery.of(context).size.height * 0.4,
      //         //width: 45,
      //         color:  Colors.white,
      //         child: Row(
      //           //mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Column(
      //               children: [
      //                 WeirdAppBar(
      //                     icon: Icons.gps_fixed_outlined,
      //                     hintText: 'موقعك الحالي'),
      //                 const SizedBox(
      //                   height: 16,
      //                 ),
      //                 WeirdAppBar(
      //                     icon: Icons.location_on_rounded,
      //                     hintText: 'جامعة الفيوم'),
      //               ],
      //             ),
      //             InkWell(
      //               onTap: () {
      //                 print('object');
      //               },
      //               child: Container(
      //                 decoration: const BoxDecoration(
      //                   shape: BoxShape.circle,
      //                   color: Color(0xffCCEBD2),
      //                 ),
      //                 child: const Padding(
      //                   padding: EdgeInsets.all(6.0),
      //                   child: Icon(
      //                     Icons.close,
      //                     fill: 1,
      //                     size: 22,
      //                     color: Color(0xff6EAD7C),
      //                   ),
      //                 ),
      //               ),
      //             )
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
