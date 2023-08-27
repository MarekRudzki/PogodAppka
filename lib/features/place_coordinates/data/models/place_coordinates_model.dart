// Package imports:
import 'package:equatable/equatable.dart';

class PlaceCoordinatesModel extends Equatable {
  final double latitude;
  final double longitude;

  PlaceCoordinatesModel(
    this.latitude,
    this.longitude,
  );

  factory PlaceCoordinatesModel.fromJson(Map<String, dynamic> json) {
    return PlaceCoordinatesModel(
        (((json['result'] as Map<String, dynamic>)['geometry']
                as Map<String, dynamic>)['location']
            as Map<String, dynamic>)['lat'] as double,
        (((json['result'] as Map<String, dynamic>)['geometry']
                as Map<String, dynamic>)['location']
            as Map<String, dynamic>)['lng'] as double);
  }

  @override
  List<Object> get props => [latitude, longitude];
}
