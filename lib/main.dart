import 'package:flutter/material.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_bloc.dart';
import 'package:tawsela_app/route_generator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(TawselaApp());
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
        BlocProvider<GoogleMapBloc>(create: (context) => GoogleMapBloc())
      ],
      child: MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: [
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
