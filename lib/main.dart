import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/models/bloc_models/language/language_bloc.dart';
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
    return BlocProvider(
      create: (context) => LanguageBloc()..add(InitialLanguage()),
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          if (state is ChangeLanguage){
            
          }
          return MaterialApp(
            locale: Locale(language),
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
              PassengerEditProfile.id: (context) =>
                  const PassengerEditProfile(),
              PassengerMainScreen.id: (context) => PassengerMainScreen(),
              MicrobusGuideStationPage.id: (context) =>
                  MicrobusGuideStationPage(color: Colors.black, line: 'line'),
              MicrobusSuggestedLinesPage.id: (context) =>
                  const MicrobusSuggestedLinesPage(),
              PassengerPickupLocationPage.id: (context) =>
                  const PassengerPickupLocationPage(),
              MicrobusRoutePage.id: (context) => MicrobusRoutePage(),
            },
            initialRoute: WelcomePage.id,
          );
        },
      ),
    );
  }
}
