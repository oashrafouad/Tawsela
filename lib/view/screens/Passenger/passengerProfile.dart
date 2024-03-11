import 'package:flutter/material.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/helper/checkLang.dart';
import 'package:tawsela_app/view/widgets/customButton.dart';
import 'package:tawsela_app/view/widgets/customTextButton.dart';
import 'package:tawsela_app/view/widgets/customTextField.dart';

class PassengerProfile extends StatelessWidget {
  const PassengerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF8F8F8),
          //centerTitle: true,
          title: Row(
        children: [
          CustomTextButton(
            radius: 5,
          )
        ],
      )),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, ),//vertical: 20),
            child: Container(
              color: Color(0xffF8F8F8),
              child: ListTile(
                minLeadingWidth: 100,
                leading: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/avatar.jpg'),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              
            ],
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
