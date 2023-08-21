// Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class WeatherRemoteDataSource {
  Future<Map<String, dynamic>?> getWeatherData({
    required String city,
  }) async {
    final weatherKey = dotenv.env['Weather_Key'];

    try {
      final response = await Dio().get<Map<String, dynamic>>(
          'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/$city?unitGroup=metric&key=$weatherKey&contentType=json');
      return response.data;
    } on DioException {
      throw Exception();
    }
  }
}
