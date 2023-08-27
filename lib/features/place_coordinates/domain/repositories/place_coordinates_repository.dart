// Package imports:
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:pogodappka/features/place_coordinates/data/datasource/place_coordinates_remote_data_source.dart';
import 'package:pogodappka/features/place_coordinates/data/models/place_coordinates_model.dart';

@lazySingleton
class PlaceCoordinatesRepository {
  final PlaceCoordinatesRemoteDataSource _coordinatesRemoteDataSource;

  PlaceCoordinatesRepository(this._coordinatesRemoteDataSource);

  Future<PlaceCoordinatesModel> getCoordinates(
      {required String placeId}) async {
    final response = await _coordinatesRemoteDataSource.getPlaceCoordinates(
        placeId: placeId);

    if (response == null) {
      return PlaceCoordinatesModel(52.069337, 19.480245);
    }

    return PlaceCoordinatesModel.fromJson(response);
  }
}
