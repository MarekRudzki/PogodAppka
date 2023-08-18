part of 'language_bloc.dart';

class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class ChangeLanguage extends LanguageEvent {
  final Language selectedLanguage;

  ChangeLanguage({
    required this.selectedLanguage,
  });

  @override
  List<Object> get props => [selectedLanguage];
}

class FetchLanguage extends LanguageEvent {}
