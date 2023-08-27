// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:pogodappka/features/places/data/datasources/autocomplete_remote_data_source.dart';
import 'package:pogodappka/features/places/data/models/place_autocomplete_model.dart';

@lazySingleton
class AutocompleteRepository {
  AutocompleteRepository(this._autocompleteRemoteDataSource);

  final AutocompleteRemoteDataSource _autocompleteRemoteDataSource;

  Future<List<PlaceAutocompleteModel>> getAutocomplete({
    required String city,
  }) async {
    final response = await _autocompleteRemoteDataSource.getPlaces(city: city);

    if (response == null) {
      return [];
    }

    final results = response['predictions'] as List;

    return results
        .map((place) =>
            PlaceAutocompleteModel.fromJson(place as Map<String, dynamic>))
        .toList();
  }
}
