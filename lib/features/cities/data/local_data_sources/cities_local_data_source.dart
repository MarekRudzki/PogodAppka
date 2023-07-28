import 'package:hive_flutter/hive_flutter.dart';

class CitiesLocalDataSource {
  final _citiesLocalDataSource = Hive.box('cities_box');

  /// Current City
  Future<void> addLatestCity({
    required String city,
    required String placeId,
  }) async {
    await _citiesLocalDataSource.put('latest_city', city);
    await _citiesLocalDataSource.put('latest_placeId', placeId);
    await addToRecentSearches(city: city, placeId: placeId);
  }

  // Check if user has searched any city before, if not return Poland capital
  String getLatestCity() {
    final bool cityExists = _citiesLocalDataSource.containsKey('latest_city');

    if (!cityExists) {
      return 'Warszawa';
    } else {
      return _citiesLocalDataSource.get('latest_city') as String;
    }
  }

  String getLatestPlaceId() {
    final bool placeIdExists =
        _citiesLocalDataSource.containsKey('latest_placeId');

    if (!placeIdExists) {
      return 'ChIJAZ-GmmbMHkcR_NPqiCq-8HI';
    } else {
      return _citiesLocalDataSource.get('latest_placeId') as String;
    }
  }

  /// Recent searches
  Future<void> addToRecentSearches({
    required String city,
    required String placeId,
  }) async {
    final newData = {city: placeId};

    if (!_citiesLocalDataSource.containsKey('recent_searches')) {
      await _citiesLocalDataSource.put('recent_searches', newData);
    } else {
      final recentSearches = _citiesLocalDataSource.get('recent_searches');

      if (recentSearches.keys.contains(city)) {
        recentSearches.removeWhere((key, value) => key == city);
        recentSearches.addEntries(newData.entries);
        return;
      }
      if (recentSearches.length == 5) {
        var firstElement = recentSearches.keys.first;
        recentSearches.removeWhere((key, value) => key == firstElement);
        recentSearches.addEntries(newData.entries);
      } else {
        recentSearches.addEntries(newData.entries);
      }
      await _citiesLocalDataSource.put('recent_searches', recentSearches);
    }
  }

  Map<String, dynamic> getRecentSearces() {
    final bool recentSearchesExists =
        _citiesLocalDataSource.containsKey('recent_searches');

    if (!recentSearchesExists) {
      return {};
    } else {
      final recentSearches = _citiesLocalDataSource.get('recent_searches');
      return Map<String, dynamic>.from(recentSearches as Map);
    }
  }
}
