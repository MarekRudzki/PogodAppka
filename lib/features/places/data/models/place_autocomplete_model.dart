// Package imports:
import 'package:equatable/equatable.dart';

class PlaceAutocompleteModel extends Equatable {
  final String description;
  final String placeId;

  PlaceAutocompleteModel({
    required this.description,
    required this.placeId,
  });

  factory PlaceAutocompleteModel.fromJson(Map<String, dynamic> json) {
    return PlaceAutocompleteModel(
      description: json['description'] as String,
      placeId: json['place_id'] as String,
    );
  }

  @override
  List<Object> get props => [description, placeId];
}
