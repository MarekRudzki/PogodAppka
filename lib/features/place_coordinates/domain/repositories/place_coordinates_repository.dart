import 'package:injectable/injectable.dart';
import 'package:pogodappka/features/place_coordinates/data/datasource/place_coordinates_remote_data_source.dart';
import 'package:pogodappka/features/place_coordinates/data/models/place_coordinates_model.dart';

@lazySingleton
class PlaceCoordinatesRepository {
  final PlaceCoordinatesRemoteDataSource _coordinatesRemoteDataSource;

  PlaceCoordinatesRepository(this._coordinatesRemoteDataSource);

  Future<PlaceCooridnatesModel> getCoordinates(
      {required String placeId}) async {
    final response = await _coordinatesRemoteDataSource.getPlaceCoordinates(
        placeId: placeId);

    if (response == null) {
      return PlaceCooridnatesModel(52.069337, 19.480245);
    }

    return PlaceCooridnatesModel.fromJson(response);
  }
}
