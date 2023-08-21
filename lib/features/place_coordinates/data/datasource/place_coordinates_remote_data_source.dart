// Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PlaceCoordinatesRemoteDataSource {
  Future<Map<String, dynamic>?> getPlaceCoordinates({
    required String placeId,
  }) async {
    final apiKey = dotenv.env['GP_Key'];

    try {
      final response = await Dio().get<Map<String, dynamic>>(
          'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey');

      return response.data;
    } on DioException {
      throw Exception();
    }
  }
}
