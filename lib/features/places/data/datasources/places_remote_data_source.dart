// Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PlacesRemoteDataSource {
  Future<Map<String, dynamic>?> getPlaces({
    required String city,
  }) async {
    final apiKey = dotenv.env['GP_Key'];

    try {
      final response = await Dio().get<Map<String, dynamic>>(
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$city&types=(cities)&key=$apiKey');
      return response.data;
    } on DioException {
      throw Exception();
    }
  }
}
