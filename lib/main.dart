import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:tawsela_app/models/bloc_models/driver_map_bloc/driver_map_bloc.dart';
import 'package:tawsela_app/models/bloc_models/user_preferences/user_preference_bloc.dart';
import 'package:tawsela_app/models/data_models/google_server.dart';
import 'package:tawsela_app/models/data_models/server.dart';
import 'package:tawsela_app/models/passenger_bloc/passenger_bloc.dart';
import 'package:tawsela_app/models/uber_driver_bloc/uber_driver_bloc.dart';
import 'package:tawsela_app/route_generator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // loading google map api key
  var json =
      await rootBundle.loadString('assets/JSON/keys/google_map_key.json');
  // decoding json string
  Map mapObject = jsonDecode(json) as Map;
  // fetching google map api key value
  String apiKey = mapObject['Google_Map_Api'];
  // register goole map api key into GET_IT
  GoogleServer APIKEY = GoogleServer(apiKey);
  GetIt.instance.registerSingleton<GoogleServer>(APIKEY);

  // loading server url
  json = await rootBundle.loadString('assets/JSON/keys/server_url.json');
  // decoding json string
  mapObject = jsonDecode(json) as Map;
  // fetching server url  value
  String server_url = mapObject['server_url'];

  // register server url into GET_IT
  Server MainServer = Server(server_url);
  GetIt.instance.registerSingleton<Server>(MainServer);

  // Bloc.observer = MyBlocObserver();
  runApp(const TawselaApp());
}

class MyBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    // TODO: implement onChange
    super.onChange(bloc, change);
    print(change.currentState.toString());
    print(change.nextState.toString());
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    // TODO: implement onEvent
    super.onEvent(bloc, event);
    print('Event ${event.toString()} has happened');
  }
}

class TawselaApp extends StatelessWidget {
  const TawselaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PassengerBloc>(create: (context) => PassengerBloc()),
        BlocProvider<DriverMapBloc>(create: (context) => DriverMapBloc()),
        BlocProvider<UberDriverBloc>(create: (context) => UberDriverBloc()),
        BlocProvider<UserPreferenceBloc>(
            create: (context) => UserPreferenceBloc())
      ],
      child: MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        initialRoute: RouteGenerator.home,
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
