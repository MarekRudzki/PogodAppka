// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

// Package imports:
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'package:pogodappka/features/cities/data/local_data_sources/cities_local_data_source.dart'
    as _i3;
import 'package:pogodappka/features/cities/domain/cities_repository.dart'
    as _i4;
import 'package:pogodappka/features/cities/presentation/blocs/cities/cities_bloc.dart'
    as _i17;
import 'package:pogodappka/features/language/data/language_local_data_source.dart'
    as _i8;
import 'package:pogodappka/features/language/domain/repositories/language_repository.dart'
    as _i9;
import 'package:pogodappka/features/language/presentation/blocs/language_bloc/language_bloc.dart'
    as _i19;
import 'package:pogodappka/features/place_coordinates/data/datasource/place_coordinates_remote_data_source.dart'
    as _i10;
import 'package:pogodappka/features/place_coordinates/domain/repositories/place_coordinates_repository.dart'
    as _i11;
import 'package:pogodappka/features/place_coordinates/presentation/blocs/place_coordinates/place_coordinates_bloc.dart'
    as _i20;
import 'package:pogodappka/features/places/data/datasources/geolocation_remote_data_source.dart'
    as _i6;
import 'package:pogodappka/features/places/data/datasources/places_remote_data_source.dart'
    as _i12;
import 'package:pogodappka/features/places/domain/repositories/geolocation_repository.dart'
    as _i7;
import 'package:pogodappka/features/places/domain/repositories/places_repository.dart'
    as _i13;
import 'package:pogodappka/features/places/presentation/blocs/autocomplete/autocomplete_bloc.dart'
    as _i16;
import 'package:pogodappka/features/places/presentation/blocs/geolocation/geolocation_bloc.dart'
    as _i18;
import 'package:pogodappka/features/weather/data/datasources/weather_remote_data_source.dart'
    as _i14;
import 'package:pogodappka/features/weather/domain/repositories/weather_repository.dart'
    as _i15;
import 'package:pogodappka/features/weather/presentation/blocs/fourteen_day_forecast/fourteen_day_forecast_bloc.dart'
    as _i5;
import 'package:pogodappka/features/weather/presentation/blocs/weather/weather_bloc.dart'
    as _i21;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.CitiesLocalDataSource>(
        () => _i3.CitiesLocalDataSource());
    gh.lazySingleton<_i4.CitiesRepository>(
        () => _i4.CitiesRepository(gh<_i3.CitiesLocalDataSource>()));
    gh.factory<_i5.FourteenDayForecastBloc>(
        () => _i5.FourteenDayForecastBloc());
    gh.lazySingleton<_i6.GeolocationRemoteDataSource>(
        () => _i6.GeolocationRemoteDataSource());
    gh.lazySingleton<_i7.GeolocationRepository>(
        () => _i7.GeolocationRepository(gh<_i6.GeolocationRemoteDataSource>()));
    gh.lazySingleton<_i8.LanguageLocalDataSource>(
        () => _i8.LanguageLocalDataSource());
    gh.lazySingleton<_i9.LanguageRepository>(
        () => _i9.LanguageRepository(gh<_i8.LanguageLocalDataSource>()));
    gh.lazySingleton<_i10.PlaceCoordinatesRemoteDataSource>(
        () => _i10.PlaceCoordinatesRemoteDataSource());
    gh.lazySingleton<_i11.PlaceCoordinatesRepository>(() =>
        _i11.PlaceCoordinatesRepository(
            gh<_i10.PlaceCoordinatesRemoteDataSource>()));
    gh.lazySingleton<_i12.PlacesRemoteDataSource>(
        () => _i12.PlacesRemoteDataSource());
    gh.lazySingleton<_i13.PlacesRepository>(
        () => _i13.PlacesRepository(gh<_i12.PlacesRemoteDataSource>()));
    gh.lazySingleton<_i14.WeatherRemoteDataSource>(
        () => _i14.WeatherRemoteDataSource());
    gh.lazySingleton<_i15.WeatherRepository>(
        () => _i15.WeatherRepository(gh<_i14.WeatherRemoteDataSource>()));
    gh.factory<_i16.AutocompleteBloc>(() =>
        _i16.AutocompleteBloc(placesRepository: gh<_i13.PlacesRepository>()));
    gh.factory<_i17.CitiesBloc>(
        () => _i17.CitiesBloc(citiesRepository: gh<_i4.CitiesRepository>()));
    gh.factory<_i18.GeolocationBloc>(() => _i18.GeolocationBloc(
        geolocationRepository: gh<_i7.GeolocationRepository>()));
    gh.factory<_i19.LanguageBloc>(() =>
        _i19.LanguageBloc(languageRepository: gh<_i9.LanguageRepository>()));
    gh.factory<_i20.PlaceCoordinatesBloc>(() => _i20.PlaceCoordinatesBloc(
        placeCoordinatesRepository: gh<_i11.PlaceCoordinatesRepository>()));
    gh.factory<_i21.WeatherBloc>(() =>
        _i21.WeatherBloc(weatherRepository: gh<_i15.WeatherRepository>()));
    return this;
  }
}
