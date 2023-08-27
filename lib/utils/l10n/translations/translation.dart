import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'translation_en.dart';
import 'translation_pl.dart';

/// Callers can lookup localized strings with an instance of WeatherTranslations
/// returned by `WeatherTranslations.of(context)`.
///
/// Applications need to include `WeatherTranslations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'translations/translation.dart';
///
/// return MaterialApp(
///   localizationsDelegates: WeatherTranslations.localizationsDelegates,
///   supportedLocales: WeatherTranslations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the WeatherTranslations.supportedLocales
/// property.
abstract class WeatherTranslations {
  WeatherTranslations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static WeatherTranslations? of(BuildContext context) {
    return Localizations.of<WeatherTranslations>(context, WeatherTranslations);
  }

  static const LocalizationsDelegate<WeatherTranslations> delegate = _WeatherTranslationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pl')
  ];

  /// No description provided for @today.
  ///
  /// In pl, this message translates to:
  /// **'DZISIAJ'**
  String get today;

  /// No description provided for @tomorrow.
  ///
  /// In pl, this message translates to:
  /// **'JUTRO'**
  String get tomorrow;

  /// No description provided for @fourteenDays.
  ///
  /// In pl, this message translates to:
  /// **'14 DNI'**
  String get fourteenDays;

  /// No description provided for @temperature.
  ///
  /// In pl, this message translates to:
  /// **'Temperatura'**
  String get temperature;

  /// No description provided for @precipitation.
  ///
  /// In pl, this message translates to:
  /// **'Opady'**
  String get precipitation;

  /// No description provided for @wind.
  ///
  /// In pl, this message translates to:
  /// **'Wiatr'**
  String get wind;

  /// No description provided for @cloudCover.
  ///
  /// In pl, this message translates to:
  /// **'Zachmurzenie'**
  String get cloudCover;

  /// No description provided for @humidity.
  ///
  /// In pl, this message translates to:
  /// **'Wilgotność'**
  String get humidity;

  /// No description provided for @pressure.
  ///
  /// In pl, this message translates to:
  /// **'Ciśnienie'**
  String get pressure;

  /// No description provided for @sunrise.
  ///
  /// In pl, this message translates to:
  /// **'Wschód'**
  String get sunrise;

  /// No description provided for @sunset.
  ///
  /// In pl, this message translates to:
  /// **'Zachód'**
  String get sunset;

  /// No description provided for @dayLength.
  ///
  /// In pl, this message translates to:
  /// **'Długość dnia i nocy'**
  String get dayLength;

  /// No description provided for @searchCity.
  ///
  /// In pl, this message translates to:
  /// **'Wpisz miasto...'**
  String get searchCity;

  /// No description provided for @useGeolocation.
  ///
  /// In pl, this message translates to:
  /// **'Użyj mojej lokalizacji'**
  String get useGeolocation;

  /// No description provided for @dateTypeLanguage.
  ///
  /// In pl, this message translates to:
  /// **'pl'**
  String get dateTypeLanguage;

  /// No description provided for @noNetworkAppBar.
  ///
  /// In pl, this message translates to:
  /// **'Brak połączenia z Internetem'**
  String get noNetworkAppBar;

  /// No description provided for @noNetworkMessage.
  ///
  /// In pl, this message translates to:
  /// **'Do korzystania z aplikacji wymagane jest połączenie z siecią.'**
  String get noNetworkMessage;

  /// No description provided for @noNetworkInstructions.
  ///
  /// In pl, this message translates to:
  /// **'Włącz Inernet, a aplikacja sama się odświeży!'**
  String get noNetworkInstructions;

  /// Weather forecast is not available for this city
  ///
  /// In pl, this message translates to:
  /// **'Prognoza dla miasta {city} jest niedostępna'**
  String cityNotAvailable(String city);

  /// No description provided for @locationDisabled.
  ///
  /// In pl, this message translates to:
  /// **'Lokalizacja jest wyłączona'**
  String get locationDisabled;

  /// No description provided for @locationRejected.
  ///
  /// In pl, this message translates to:
  /// **'Odrzucono prośbę o dostęp do lokalizacji'**
  String get locationRejected;

  /// No description provided for @locationDisabledForever.
  ///
  /// In pl, this message translates to:
  /// **'Lokalizacja jest wyłączona na stałe, nie można zlokalizować Twojej pozycji'**
  String get locationDisabledForever;

  /// No description provided for @cannotGeolocate.
  ///
  /// In pl, this message translates to:
  /// **'Obecnie nie można zlokalizować Twojej pozycji. Spróbuj wyszukać ją ręcznie'**
  String get cannotGeolocate;

  /// No description provided for @errorCitySearch.
  ///
  /// In pl, this message translates to:
  /// **'Błąd! Coś poszło nie tak. Spróbuj wyszukać miasto ponownie.'**
  String get errorCitySearch;

  /// No description provided for @errorWeather.
  ///
  /// In pl, this message translates to:
  /// **'Nie można załadować pogody'**
  String get errorWeather;
}

class _WeatherTranslationsDelegate extends LocalizationsDelegate<WeatherTranslations> {
  const _WeatherTranslationsDelegate();

  @override
  Future<WeatherTranslations> load(Locale locale) {
    return SynchronousFuture<WeatherTranslations>(lookupWeatherTranslations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_WeatherTranslationsDelegate old) => false;
}

WeatherTranslations lookupWeatherTranslations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return WeatherTranslationsEn();
    case 'pl': return WeatherTranslationsPl();
  }

  throw FlutterError(
    'WeatherTranslations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
