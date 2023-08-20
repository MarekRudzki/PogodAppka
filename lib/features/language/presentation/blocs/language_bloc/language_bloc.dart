import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pogodappka/features/language/domain/repositories/language_repository.dart';
import 'package:pogodappka/features/language/language.dart';

part 'language_event.dart';
part 'language_state.dart';

@injectable
class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final LanguageRepository languageRepository;
  LanguageBloc({required this.languageRepository})
      : super(const LanguageState()) {
    on<ChangeLanguage>(_onChangeLanguage);
    on<FetchLanguage>(_onFetchLanguage);
  }

  Future<void> _onChangeLanguage(
      ChangeLanguage event, Emitter<LanguageState> emit) async {
    await languageRepository.changeLanguage(language: event.selectedLanguage);
    emit(state.copyWith(selectedLanguage: event.selectedLanguage));
  }

  void _onFetchLanguage(FetchLanguage event, Emitter<LanguageState> emit) {
    final Language savedLanguage = languageRepository.getLanguage();
    emit(state.copyWith(selectedLanguage: savedLanguage));
  }
}
