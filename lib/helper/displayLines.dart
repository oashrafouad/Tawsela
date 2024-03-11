import 'package:tawsela_app/helper/checkLang.dart';

String displayLines(int i){

  List<String>lines=["١","٢","٣","٤","٥","٦","٧","٨","٩","١٠","١١","١٢","١٣","١٤","١٥","١٦","١٧"];
  if(isArabic()) return lines[i-1].toString();
  return i.toString();
  

}