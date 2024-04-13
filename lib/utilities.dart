import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:math';
import 'dart:ui';

import 'package:tawsela_app/constants.dart';

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}

String displayLines(int i) {
  List<String> lines = [ "١","٢","٣", "٤","٥","٦","٧","٨", "٩", "١٠", "١١","١٢","١٣","١٤", "١٥","١٦","١٧"];
  
  if (isArabic()) return lines[i - 1].toString();
  return i.toString();
}

pickImage(ImageSource source) async {
  final ImagePicker imgPicker = ImagePicker();
  XFile? file = await imgPicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  }
  print('No img Selected');
}

Color randomColorsGenerator() {
  Random random = Random();
  return linesColors[random.nextInt(linesColors.length)];
}
