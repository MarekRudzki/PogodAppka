// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:pogodappka/utils/l10n/translations/translation.dart';

export 'package:pogodappka/utils/l10n/translations/translation.dart';

extension LocalizationContext on BuildContext {
  WeatherTranslations get l10n => WeatherTranslations.of(this)!;
}
