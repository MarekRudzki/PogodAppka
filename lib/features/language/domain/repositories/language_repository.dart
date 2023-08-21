// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:pogodappka/features/language/data/language_local_data_source.dart';
import 'package:pogodappka/features/language/language.dart';

@lazySingleton
class LanguageRepository {
  final LanguageLocalDataSource languageLocalDataSource;

  LanguageRepository(
    this.languageLocalDataSource,
  );

  Future<void> changeLanguage({
    required Language language,
  }) async {
    if (language == Language.polish) {
      await languageLocalDataSource.changeLanguage(language: 'polish');
    } else {
      await languageLocalDataSource.changeLanguage(language: 'english');
    }
  }

  Language getLanguage() {
    final language = languageLocalDataSource.getLangauge();

    if (language == 'polish') {
      return Language.polish;
    } else {
      return Language.english;
    }
  }
}
