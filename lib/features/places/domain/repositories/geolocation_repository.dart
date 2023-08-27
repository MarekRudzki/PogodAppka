// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:pogodappka/features/cities/data/models/city_model.dart';
import 'package:pogodappka/features/places/data/datasources/geolocation_remote_data_source.dart';

@lazySingleton
class GeolocationRepository {
  final GeolocationRemoteDataSource _geolocationRemoteDataSource;

  GeolocationRepository(this._geolocationRemoteDataSource);

  Future<CityModel> getCurrentLocation() async {
    final response = await _geolocationRemoteDataSource.getCurrentGeolocation();

    final responseList = response['results'] as List<dynamic>;
    final convertedResponse =
        responseList.map((e) => e as Map<String, dynamic>).toList();
    final String placeId = convertedResponse.first['place_id'] as String;
    final String adress = await _geolocationRemoteDataSource.getAdress();

    return CityModel(
      name: adress,
      placeId: placeId,
    );
  }
}
