import 'package:pogodappka/features/cities/data/local_data_sources/cities_local_data_source.dart';
import 'package:pogodappka/features/cities/data/models/city_model.dart';

class CitiesRepository {
  final CitiesLocalDataSource _citiesLocalDataSource;

  CitiesRepository(this._citiesLocalDataSource);

  Future<void> addLatestCity({
    required CityModel cityModel,
  }) async {
    await _citiesLocalDataSource.addLatestCity(
      city: cityModel.name,
      placeId: cityModel.placeId,
    );
  }

  CityModel getLatestCity() {
    final latestCityName = _citiesLocalDataSource.getLatestCity();
    final latestPlaceId = _citiesLocalDataSource.getLatestPlaceId();
    return CityModel(name: latestCityName, placeId: latestPlaceId);
  }

  List<CityModel> getRecentSearches() {
    List<CityModel> recentCitiesSearches = [];
    final recentSearches = _citiesLocalDataSource.getRecentSearces();

    final cityName =
        List<String>.from(recentSearches.keys.map((String city) => city))
            .toList();
    final placeId =
        List<String>.from(recentSearches.values.map((placeId) => placeId))
            .toList();
    for (int i = 0; i < cityName.length; i++) {
      recentCitiesSearches
          .add(CityModel(name: cityName[i], placeId: placeId[i]));
    }
    return recentCitiesSearches;
  }
}
