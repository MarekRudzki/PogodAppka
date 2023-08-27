import 'translation.dart';

/// The translations for Polish (`pl`).
class WeatherTranslationsPl extends WeatherTranslations {
  WeatherTranslationsPl([String locale = 'pl']) : super(locale);

  @override
  String get today => 'DZISIAJ';

  @override
  String get tomorrow => 'JUTRO';

  @override
  String get fourteenDays => '14 DNI';

  @override
  String get temperature => 'Temperatura';

  @override
  String get precipitation => 'Opady';

  @override
  String get wind => 'Wiatr';

  @override
  String get cloudCover => 'Zachmurzenie';

  @override
  String get humidity => 'Wilgotność';

  @override
  String get pressure => 'Ciśnienie';

  @override
  String get sunrise => 'Wschód';

  @override
  String get sunset => 'Zachód';

  @override
  String get dayLength => 'Długość dnia i nocy';

  @override
  String get searchCity => 'Wpisz miasto...';

  @override
  String get useGeolocation => 'Użyj mojej lokalizacji';

  @override
  String get dateTypeLanguage => 'pl';

  @override
  String get noNetworkAppBar => 'Brak połączenia z Internetem';

  @override
  String get noNetworkMessage => 'Do korzystania z aplikacji wymagane jest połączenie z siecią.';

  @override
  String get noNetworkInstructions => 'Włącz Inernet, a aplikacja sama się odświeży!';

  @override
  String cityNotAvailable(String city) {
    return 'Prognoza dla miasta $city jest niedostępna';
  }

  @override
  String get locationDisabled => 'Lokalizacja jest wyłączona';

  @override
  String get locationRejected => 'Odrzucono prośbę o dostęp do lokalizacji';

  @override
  String get locationDisabledForever => 'Lokalizacja jest wyłączona na stałe, nie można zlokalizować Twojej pozycji';

  @override
  String get cannotGeolocate => 'Obecnie nie można zlokalizować Twojej pozycji. Spróbuj wyszukać ją ręcznie';

  @override
  String get errorCitySearch => 'Błąd! Coś poszło nie tak. Spróbuj wyszukać miasto ponownie.';

  @override
  String get errorWeather => 'Nie można załadować pogody';
}
