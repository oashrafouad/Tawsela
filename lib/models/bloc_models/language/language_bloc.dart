import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tawsela_app/constants.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitial()) {
    on<LanguageEvent>((event, emit) {
      if (event is InitialLanguage) {
      if (language=='ar'){
          emit(ChangeLanguage(languageCode: 'ar'));
      }else {
        emit(ChangeLanguage(languageCode: 'en'));
      }

      } else if (event is EnglishLanguageEvent) {
        language='en';
        emit(ChangeLanguage(languageCode: language));
      } else if (event is ArabicLanguageEvent) {
        language='ar';
        emit(ChangeLanguage(languageCode: language));
      }
    });
  }
}
