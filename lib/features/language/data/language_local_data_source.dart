// Package imports:
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LanguageLocalDataSource {
  final _languageBox = Hive.box('language');

  Future<void> changeLanguage({
    required String language,
  }) async {
    await _languageBox.put('current_language', language);
  }

  String getLangauge() {
    if (_languageBox.isNotEmpty) {
      return _languageBox.get('current_language') as String;
    } else {
      return 'polish';
    }
  }
}
