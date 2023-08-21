// Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:location_geocoder/location_geocoder.dart';

// Project imports:
import 'package:pogodappka/features/cities/data/models/city_model.dart';
import 'package:pogodappka/features/places/data/datasources/geolocation_remote_data_source.dart';

@lazySingleton
class GeolocationRepository {
  final GeolocationRemoteDataSource _geolocationRemoteDataSource;

  GeolocationRepository(this._geolocationRemoteDataSource);

  Future<CityModel> getCurrentLocation() async {
    final apiKey = dotenv.env['GP_Key'];
    final LocatitonGeocoder geocoder = LocatitonGeocoder(apiKey.toString());

    try {
      final currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
        timeLimit: const Duration(seconds: 5),
      );

      final response = await _geolocationRemoteDataSource.getCurrentGeolocation(
        apiKey: apiKey!,
        currentPosition: currentPosition,
      );
      final responseList = response['results'] as List<dynamic>;
      final convertedResponse =
          responseList.map((e) => e as Map<String, dynamic>).toList();
      final String placeId = convertedResponse.first['place_id'] as String;

      final address = await geocoder.findAddressesFromCoordinates(
        Coordinates(currentPosition.latitude, currentPosition.longitude),
      );
      return CityModel(
        name: address.first.locality!,
        placeId: placeId,
      );
    } catch (error) {
      throw Exception();
    }
  }
}
