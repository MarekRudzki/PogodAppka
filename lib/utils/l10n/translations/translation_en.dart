import 'translation.dart';

/// The translations for English (`en`).
class WeatherTranslationsEn extends WeatherTranslations {
  WeatherTranslationsEn([String locale = 'en']) : super(locale);

  @override
  String get today => 'TODAY';

  @override
  String get tomorrow => 'TOMORROW';

  @override
  String get fourteenDays => '14 DAYS';

  @override
  String get temperature => 'Temperature';

  @override
  String get precipitation => 'Precipitation';

  @override
  String get wind => 'Wind';

  @override
  String get cloudCover => 'Cloud cover';

  @override
  String get humidity => 'Humidity';

  @override
  String get pressure => 'Pressure';

  @override
  String get sunrise => 'Sunrise';

  @override
  String get sunset => 'Sunset';

  @override
  String get dayLength => 'Length of day and night';

  @override
  String get searchCity => 'Search city...';

  @override
  String get useGeolocation => 'Use my location';

  @override
  String get dateTypeLanguage => 'en';

  @override
  String get noNetworkAppBar => 'No Internet connection';

  @override
  String get noNetworkMessage => 'A network connection is required to use the application.';

  @override
  String get noNetworkInstructions => 'Turn on Inernet and the application will refresh!';

  @override
  String cityNotAvailable(String city) {
    return 'Forecast for $city is unavailable';
  }

  @override
  String get locationDisabled => 'Location is disabled';

  @override
  String get locationRejected => 'Location service request rejected';

  @override
  String get locationDisabledForever => 'Location is permanently disabled, your position cannot be located';

  @override
  String get cannotGeolocate => 'Currently, your position cannot be located. Try searching for it manually';

  @override
  String get errorCitySearch => 'Something went wrong. Try searching for the city again.';

  @override
  String get errorWeather => 'Cannot load weather';
}
