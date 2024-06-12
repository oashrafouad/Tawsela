import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tawsela_app/constants.dart';
import 'package:tawsela_app/generated/l10n.dart';
import 'package:tawsela_app/models/bloc_models/lang/app_language_bloc.dart';
import 'package:tawsela_app/models/imageCubit/image_cubit.dart';


// Import screens
import 'package:tawsela_app/view/screens/Driver/driver_main_screen.dart';
import 'package:tawsela_app/view/screens/Driver/driver_signup.dart';
import 'package:tawsela_app/view/screens/Driver/driver_profile.dart';
import 'package:tawsela_app/view/screens/Driver/driver_pickup_location.dart';
import 'package:tawsela_app/view/screens/Driver/driver_edit_profile.dart';
import 'package:tawsela_app/view/screens/Driver/testPics.dart';
import 'package:tawsela_app/view/screens/Passenger/sms_verfication.dart';
import 'package:tawsela_app/view/screens/Passenger/passenger_signup.dart';
import 'package:tawsela_app/view/screens/Passenger/passenger_profile.dart';
import 'package:tawsela_app/view/screens/Passenger/passenger_edit_profile.dart';
import 'package:tawsela_app/view/screens/Passenger/passenger_main_screen.dart';
import 'package:tawsela_app/view/screens/Passenger/microbus_guide_station.dart';
import 'package:tawsela_app/view/screens/Passenger/microbus_suggested_lines.dart';
import 'package:tawsela_app/view/screens/Passenger/passenger_pickup_location.dart';
import 'package:tawsela_app/view/screens/Passenger/microbus_route.dart';
import 'package:tawsela_app/view/screens/Passenger/welcome_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  // lock orientation to portrait only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);
  runApp(const TawselaApp());
}

class TawselaApp extends StatelessWidget {
  const TawselaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppLanguageBloc()..add(InitialLanguage()),
        ),
        BlocProvider(
          create: (context) => ImageCubit(), // provide the ImageCubit
        ),
      ],
      child: Builder(
        builder: (context) {
          final langState = context.select((AppLanguageBloc bloc) => bloc.state);

          return MaterialApp(
            locale: _getLocale(langState),
            debugShowCheckedModeBanner: false,
            supportedLocales: const [Locale('ar'), Locale('en')],
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: _localeResolutionCallback,
            routes: _buildRoutes(),
            initialRoute: WelcomePage.id,
          );
        },
      ),
    );
  }

  Locale _getLocale(AppLanguageState langState) {
    if (langState is AppChangeLanguage) {
      return langState.languageCode == 'en' ? const Locale('en') : const Locale('ar');
    }
    return const Locale('ar');
  }

  Locale? _localeResolutionCallback(Locale? deviceLocale, Iterable<Locale> supportedLocales) {
    if (deviceLocale != null) {
      for (var locale in supportedLocales) {
        if (deviceLocale.languageCode == locale.languageCode) {
          return deviceLocale;
        }
      }
    }
    return supportedLocales.first;
  }

  Map<String, WidgetBuilder> _buildRoutes() {
    return {
      WelcomePage.id: (context) =>  WelcomePage(),
      SmsVerficationPage.id: (context) =>  SmsVerficationPage(),
      PassengerSignUpPage.id: (context) => const PassengerSignUpPage(),
      PassengerProfile.id: (context) => const PassengerProfile(),
      PassengerEditProfile.id: (context) => const PassengerEditProfile(),
      PassengerMainScreen.id: (context) => const PassengerMainScreen(),
      MicrobusGuideStationPage.id: (context) => MicrobusGuideStationPage(color: Colors.black, line: 'line'),
      MicrobusSuggestedLinesPage.id: (context) => const MicrobusSuggestedLinesPage(),
      PassengerPickupLocationPage.id: (context) => const PassengerPickupLocationPage(),
      MicrobusRoutePage.id: (context) =>  MicrobusRoutePage(),
      DriverMainScreen.id: (context) =>  const DriverMainScreen(),
      DriverSignUpPage.id: (context) =>  DriverSignUpPage(),
      DriverProfilePage.id: (context) =>  const DriverProfilePage(),
      DriverPickupLocationPage.id: (context) => const DriverPickupLocationPage(),
      DriverEditProfilePage.id: (context) =>  DriverEditProfilePage(),
      TestpicsPage.id: (context) =>  const TestpicsPage(),
    };
  }
}

