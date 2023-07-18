import 'package:pogodappka/features/places/data/datasources/places_remote_data_source.dart';
import 'package:pogodappka/features/places/data/models/place_autocomplete_model.dart';

class PlacesRepository {
  PlacesRepository(this._placeesRemoteDataSource);

  final PlacesRemoteDataSource _placeesRemoteDataSource;

  Future<List<PlaceAutocompleteModel>> getAutocomplete(
      {required String city}) async {
    final response = await _placeesRemoteDataSource.getPlaces(city: city);

    if (response == null) {
      return [];
    }

    var results = response['predictions'] as List;

    return results
        .map((place) => PlaceAutocompleteModel.fromJson(place))
        .toList();
  }
}
