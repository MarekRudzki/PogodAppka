import 'package:injectable/injectable.dart';
import 'package:pogodappka/features/cities/data/models/city_model.dart';
import 'package:pogodappka/features/places/data/datasources/geolocation_remote_data_source.dart';

@lazySingleton
class GeolocationRepository {
  final GeolocationRemoteDataSource _geolocationRemoteDataSource;

  GeolocationRepository(this._geolocationRemoteDataSource);

  Future<CityModel> getCurrentLocation() async {
    final CityModel currentCity =
        await _geolocationRemoteDataSource.getCurrentGeolocation();

    return currentCity;
  }
}
