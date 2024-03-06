import 'package:flutter/material.dart';
import 'package:tawsela_app/route_generator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(TawselaApp());
}

class TawselaApp extends StatelessWidget {
  const TawselaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [],
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
