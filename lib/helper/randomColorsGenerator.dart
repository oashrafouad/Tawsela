import 'dart:math';
import 'dart:ui';

import 'package:tawsela_app/constants.dart';

Color randomColorsGenerator() {
  Random random = Random();
  return linesColors[random.nextInt(linesColors.length)];
}