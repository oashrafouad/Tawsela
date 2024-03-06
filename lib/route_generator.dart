import 'package:flutter/material.dart';
import 'package:tawsela_app/routes/home_page.dart';

class RouteGenerator {
  static const String home = '/';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (context) => HomePage());
      default:
        throw FormatException('Route not found');
    }
  }
}
