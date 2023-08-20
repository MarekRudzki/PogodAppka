import 'package:injectable/injectable.dart';
import 'package:pogodappka/features/places/data/datasources/places_remote_data_source.dart';
import 'package:pogodappka/features/places/data/models/place_autocomplete_model.dart';

@lazySingleton
class PlacesRepository {
  PlacesRepository(this._placeesRemoteDataSource);

  final PlacesRemoteDataSource _placeesRemoteDataSource;

  Future<List<PlaceAutocompleteModel>> getAutocomplete({
    required String city,
  }) async {
    final response = await _placeesRemoteDataSource.getPlaces(city: city);

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
