// Package imports:
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GeolocationRemoteDataSource {
  Future<Map<String, dynamic>> getCurrentGeolocation({
    required String apiKey,
    required Position currentPosition,
  }) async {
    try {
      final response = await Dio().get<Map<String, dynamic>>(
          'https://maps.googleapis.com/maps/api/geocode/json?&latlng=${currentPosition.latitude}%2C${currentPosition.longitude}&key=$apiKey');
      return response.data!;
    } catch (error) {
      throw Exception();
    }
  }
}
