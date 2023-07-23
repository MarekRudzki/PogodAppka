import 'package:pogodappka/features/cities/data/local_data_sources/cities_local_data_source.dart';

class CitiesRepository {
  final CitiesLocalDataSource _citiesLocalDataSource;

  CitiesRepository(this._citiesLocalDataSource);

  Future<void> addLatestCity({required String city}) async {
    await _citiesLocalDataSource.addLatestCity(city: city);
  }

  String getLatestCity() {
    final latestCity = _citiesLocalDataSource.getLatestCity();
    return latestCity;
  }

  List<String> getRecentSearches() {
    final recentSearches = _citiesLocalDataSource.getRecentSearces();
    return recentSearches;
  }
}
