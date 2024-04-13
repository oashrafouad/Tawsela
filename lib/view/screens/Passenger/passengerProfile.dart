import 'package:flutter/material.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/view/screens/Passenger/passengerEditProfile.dart';
import 'package:tawsela_app/view/widgets/customTextButton.dart';

class PassengerProfile extends StatelessWidget {
  const PassengerProfile({super.key});
  static String id='PassengerProfilePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.green),
          backgroundColor: const Color(0xffF8F8F8),
          //centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomTextButton(
                text: S.of(context).switchDriverMode,
                radius: 10,
                fontSize: 10,
                fontWeight: FontWeight.w400,
                paddingVerti: 6,
                icon: Icons.swap_vertical_circle_outlined,
                iconSize: 20,
              ),
              const SizedBox(
                width: 8,
              ),
              CustomTextButton(
                radius: 10,
                textColor: const Color(0xffD16464),
                iconColor: const Color(0xffD16464),
                buttonColor: const Color(0xffFFA8A8),
                paddingVerti: 6,
                icon: Icons.logout,
                paddingHorzin: 2,
                iconSize: 20,
              ),
            ],
          )),
      body: ListView(
        children: [
          Container(
            color: const Color(0xffF8F8F8),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
              child: Column(
                children: [
                  Row(children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/avatar.jpg'),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'أحمد علاء',
                              style: TextStyle(
                                  fontFamily: font,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: const Color(0xffE7E7E7),
                                  border: Border.all(
                                    color: const Color(0xffCECECE),
                                    width: 1,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child:  InkWell(
                                    focusColor: noColor,
                                    splashColor: noColor,
                                    hoverColor: noColor,
                                    highlightColor: noColor,
                                    child: Icon(Icons.edit_outlined)
                                    ,onTap: () {
                                      Navigator.pushNamed(context, PassengerEditProfile.id);
                                    },
                                    )
,                               // onTap: onTap,

                                ),
                          ],
                        ),
                        const Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            Text('5.0')
                          ],
                        ),
                      ],
                    ),
                  ]),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    S.of(context).numberoftrips,
                    style: TextStyle(
                        color: const Color(0xff525252),
                        fontFamily: font,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    S.of(context).trip,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: font,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),

                  //Text('Ahme')
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).tripLog,
                  style: TextStyle(
                      color: const Color(0xff303030),
                      fontFamily: font,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                CustomTextButton(
                  icon: Icons.arrow_forward_ios,
                  text: S.of(context).showAll,
                  fontSize: 12,
                )
              ],
            ),
          ),
          for (int i=0;i<3;i++)
          Column(
            children: [
              ListTile(
                //contentPadding:EdgeInsets.symmetric(vertical: 16,horizontal: 16) ,
                leading: const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/avatar.jpg'),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'أحمد علاء',
                          style: TextStyle(
                              fontFamily: font,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Icons.star,
                          size: 15,
                          color: Colors.amber,
                        ),
                        Text(
                          '5.0',
                          style: TextStyle(
                              fontFamily: font,
                              fontSize: 9,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ],
                ),
              
                trailing: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'المسلة',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w400,
                                fontFamily: font,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2),
                              child: Icon(
                                Icons.arrow_forward,
                                size: 15,
                              ),
                            ),
                            Text(
                              'جامعة الفيوم',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w400,
                                fontFamily: font,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:4.0),
                        child: Text(
                          '٤:٥٠ مساءً - ٥:١٠ مساءً',
                          style: TextStyle(
                              color: const Color(
                                0xff858585,
                              ),
                              fontFamily: font,
                              fontSize: 9,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8,),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 
                 16.0),
                child: Divider(thickness: 1,),
              ),
              const SizedBox(height: 8,)
            ],
          ),
          
        ],
      ),
    );
  }
}
