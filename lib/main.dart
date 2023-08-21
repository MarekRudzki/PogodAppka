// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

// Project imports:
import 'package:pogodappka/features/cities/domain/cities_repository.dart';
import 'package:pogodappka/features/cities/presentation/blocs/cities/cities_bloc.dart';
import 'package:pogodappka/features/language/presentation/blocs/language_bloc/language_bloc.dart';
import 'package:pogodappka/features/place_coordinates/presentation/blocs/place_coordinates/place_coordinates_bloc.dart';
import 'package:pogodappka/features/places/presentation/blocs/autocomplete/autocomplete_bloc.dart';
import 'package:pogodappka/features/places/presentation/blocs/geolocation/geolocation_bloc.dart';
import 'package:pogodappka/features/weather/presentation/blocs/fourteen_day_forecast/fourteen_day_forecast_bloc.dart';
import 'package:pogodappka/features/weather/presentation/blocs/weather/weather_bloc.dart';
import 'package:pogodappka/features/weather/presentation/views/home_screen.dart';
import 'package:pogodappka/utils/di.dart';
import 'package:pogodappka/utils/l10n/translations/translation.dart';

void main() async {
  configureDependencies();
  await Hive.initFlutter();
  await Hive.openBox('cities_box');
  await Hive.openBox('language');

  await dotenv.load();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then(
    (_) => initializeDateFormatting('pl').then(
      (_) => runApp(
        MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) =>
                    getIt<AutocompleteBloc>()..add(const LoadAutocomplete())),
            BlocProvider(create: (context) => getIt<GeolocationBloc>()),
            BlocProvider(
                create: (context) =>
                    getIt<CitiesBloc>()..add(LoadLatestCity())),
            BlocProvider(
                create: (context) => getIt<WeatherBloc>()
                  ..add(FetchWeather(
                      city: getIt<CitiesRepository>().getLatestCity().name))),
            BlocProvider(
              create: (context) => getIt<PlaceCoordinatesBloc>()
                ..add(FetchPlaceCoordinates(
                    placeId:
                        getIt<CitiesRepository>().getLatestCity().placeId)),
            ),
            BlocProvider(create: (context) => getIt<FourteenDayForecastBloc>()),
            BlocProvider(
                create: (context) =>
                    getIt<LanguageBloc>()..add(FetchLanguage()))
          ],
          child: BlocBuilder<LanguageBloc, LanguageState>(
            builder: (context, state) {
              return MaterialApp(
                localizationsDelegates: [
                  WeatherTranslations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate
                ],
                locale: state.selectedLanguage.locale,
                supportedLocales: [
                  const Locale('pl', ''),
                  const Locale('en', ''),
                ],
                title: 'PogodAppka',
                debugShowCheckedModeBanner: false,
                home: const HomeScreen(),
              );
            },
          ),
        ),
      ),
    ),
  );
}
