import 'dart:ui';

enum Language {
  english(
    locale: Locale('en', 'EN'),
    code: 'en',
    languageName: 'English',
  ),
  polish(
    locale: Locale('pl', 'PL'),
    code: 'PL',
    languageName: 'Polski',
  );

  const Language({
    required this.locale,
    required this.code,
    required this.languageName,
  });

  final Locale locale;
  final String code;
  final String languageName;
}
