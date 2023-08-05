import 'package:pogodappka/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:pogodappka/features/weather/data/models/weather_data.dart';

class WeatherRepository {
  WeatherRepository(this._weatherRemoteDataSource);

  final WeatherRemoteDataSource _weatherRemoteDataSource;

  Future<WeatherData?> getWeatherData({
    required String city,
  }) async {
    final json = await _weatherRemoteDataSource.getWeatherData(city: city);

    if (json == null) {
      return null;
    }

    return WeatherData.fromJson(json);
  }
}
