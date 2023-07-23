import 'package:hive_flutter/hive_flutter.dart';

class CitiesLocalDataSource {
  final _citiesLocalDataSource = Hive.box('cities_box');

  /// Current City
  Future<void> addLatestCity({required String city}) async {
    await _citiesLocalDataSource.put('latest_city', city);
    await addToRecentSearches(city: city);
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

  /// Recent searches
  Future<void> addToRecentSearches({required String city}) async {
    if (!_citiesLocalDataSource.containsKey('recent_searches')) {
      _citiesLocalDataSource.put('recent_searches', [city]);
    } else {
      final List<String> recentSearches =
          _citiesLocalDataSource.get('recent_searches');

      if (recentSearches.contains(city)) {
        recentSearches.removeAt(recentSearches.indexOf(city));
        recentSearches.add(city);
        return;
      }
      if (recentSearches.length == 5) {
        recentSearches.removeAt(0);
        recentSearches.add(city);
      } else {
        recentSearches.add(city);
      }
    }
  }

  List<String> getRecentSearces() {
    final bool recentSearchesExists =
        _citiesLocalDataSource.containsKey('recent_searches');

    if (!recentSearchesExists) {
      return [];
    } else {
      final List<String> recentSearches =
          _citiesLocalDataSource.get('recent_searches') as List<String>;
      return recentSearches.reversed.toList();
    }
  }
}
