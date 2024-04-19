import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/models/bloc_models/lang/app_language_bloc.dart';
import 'package:tawsela_app/models/bloc_models/theme/app_theme_bloc.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const TawselaApp());
}

class TawselaApp extends StatelessWidget {
  const TawselaApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppThemeBloc()..add(InitialEvent()),
          ),
          BlocProvider(
            create: (context) => AppLanguageBloc()..add(InitialLanguage()),
          ),
        ],
        child: Builder(
          builder: (context) {
            var themeState = context.select((AppThemeBloc bloc) => bloc.state);
            var langState =
                context.select((AppLanguageBloc bloc) => bloc.state);

            return MaterialApp(
              locale: langState is AppChangeLanguage
                  ? langState.languageCode == 'en'
                      ? const Locale('en')
                      : const Locale('ar')
                  : const Locale('ar'),
              theme: themeState is AppChangeTheme
                  ? themeState.appTheme == 'l'
                      ? ThemeData.light()
                      : ThemeData.light() // dark theme looks like shit ,we gonna fix it 
                  : ThemeData.light(),
              debugShowCheckedModeBanner: false,
              supportedLocales: const [Locale('ar'), Locale('en')],
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              localeResolutionCallback: (deviceLocale, supportedLocales) {
                for (var locale in supportedLocales) {
                  if (deviceLocale != null) {
                    if (deviceLocale.languageCode == locale.languageCode) {
                      return deviceLocale;
                    }
                  }
                }
                return supportedLocales.first;
              },
              routes: {
                WelcomePage.id: (context) => const WelcomePage(),
                SmsVerficationPage.id: (context) => const SmsVerficationPage(),
                PassengerSignUpPage.id: (context) =>
                    const PassengerSignUpPage(),
                PassengerProfile.id: (context) => const PassengerProfile(),
                PassengerEditProfile.id: (context) =>
                    const PassengerEditProfile(),
                PassengerMainScreen.id: (context) =>
                    const PassengerMainScreen(),
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
        ));
  }
}



// MaterialApp(
//             locale: Locale(language),
//             localizationsDelegates: const [
//               S.delegate,
//               GlobalMaterialLocalizations.delegate,
//               GlobalWidgetsLocalizations.delegate,
//               GlobalCupertinoLocalizations.delegate,
//             ],
//             supportedLocales: S.delegate.supportedLocales,
//             debugShowCheckedModeBanner: false,
//             routes: {
//               WelcomePage.id: (context) => const WelcomePage(),
//               SmsVerficationPage.id: (context) => const SmsVerficationPage(),
//                PassengerSignUpPage.id: (context) => const PassengerSignUpPage(),
//               PassengerProfile.id: (context) => const PassengerProfile(),
//               PassengerEditProfile.id: (context) =>
//                   const PassengerEditProfile(),
//               PassengerMainScreen.id: (context) => const PassengerMainScreen(),
//               MicrobusGuideStationPage.id: (context) =>
//                   MicrobusGuideStationPage(color: Colors.black, line: 'line'),
//               MicrobusSuggestedLinesPage.id: (context) =>
//                   const MicrobusSuggestedLinesPage(),
//               PassengerPickupLocationPage.id: (context) =>
//                   const PassengerPickupLocationPage(),
//               MicrobusRoutePage.id: (context) => MicrobusRoutePage(),
//             },
//             initialRoute: WelcomePage.id,
//           );