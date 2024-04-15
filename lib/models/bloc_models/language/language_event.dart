part of 'language_bloc.dart';

@immutable
sealed class LanguageEvent {}
class InitialLanguage extends LanguageEvent{}
class ArabicLanguageEvent extends LanguageEvent{}
class EnglishLanguageEvent extends LanguageEvent{}