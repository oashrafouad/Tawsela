import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tawsela_app/view/screens/Driver/driverPickupLocation.dart';
import 'package:tawsela_app/view/screens/Driver/driverProfile.dart';
import 'package:tawsela_app/view/screens/Driver/driverSignUp.dart';
import 'package:tawsela_app/view/screens/Driver/driverEditProfile.dart';
import 'package:tawsela_app/view/screens/Passenger/WelcomePage.dart';
import 'package:tawsela_app/view/screens/Passenger/microbusGuideStation.dart';
import 'package:tawsela_app/view/screens/Passenger/microbusRoute.dart';
import 'package:tawsela_app/view/screens/Passenger/microbusSuggestedLines.dart';
import 'package:tawsela_app/view/screens/Passenger/passengerEditProfile.dart';
import 'package:tawsela_app/view/screens/Passenger/passengerMainScreen.dart';
import 'package:tawsela_app/view/screens/Passenger/passengerPickupLocation.dart';
import 'package:tawsela_app/view/screens/Passenger/passengerProfile.dart';
import 'package:tawsela_app/view/screens/Passenger/passengerSignUp.dart';
import 'package:tawsela_app/view/screens/Passenger/smsVerfication.dart';
import 'generated/l10n.dart';

void main() {
  runApp(const TawselaApp());
}

class TawselaApp extends StatelessWidget {
  const TawselaApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('ar'),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      routes: {
        WelcomePage.id: (context) => const WelcomePage(),
        SmsVerficationPage.id: (context) => const SmsVerficationPage(),
        PassengerSignUpPage.id: (context) => PassengerSignUpPage(),
        PassengerProfile.id: (context) => const PassengerProfile(),
        PassengerEditProfile.id: (context) => const PassengerEditProfile(),
        PassengerMainScreen.id: (context) => const PassengerMainScreen(),
        MicrobusGuideStationPage.id: (context) =>
            MicrobusGuideStationPage(color: Colors.black, line: 'line'),
        MicrobusSuggestedLinesPage.id: (context) =>
            const MicrobusSuggestedLinesPage(),
        PassengerPickupLocationPage.id: (context) =>
            const PassengerPickupLocationPage(),
        MicrobusRoutePage.id: (context) => MicrobusRoutePage()
        ,
      },
      initialRoute: MicrobusRoutePage.id,
    );
  }
}
