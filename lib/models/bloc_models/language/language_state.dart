part of 'language_bloc.dart';

@immutable
sealed class LanguageState {}

final class LanguageInitial extends LanguageState {}

class ChangeLanguage extends LanguageState{
  final String languageCode;

  ChangeLanguage({required this.languageCode});
  
}

