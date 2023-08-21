part of 'language_bloc.dart';

class LanguageState extends Equatable {
  final Language selectedLanguage;

  const LanguageState({
    Language? selectedLanguage,
  }) : selectedLanguage = selectedLanguage ?? Language.polish;

  @override
  List<Object> get props => [selectedLanguage];

  LanguageState copyWith({Language? selectedLanguage}) {
    return LanguageState(
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    );
  }
}
