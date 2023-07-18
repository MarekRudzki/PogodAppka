class PlaceAutocompleteModel {
  final String description;
  final String placeId;

  PlaceAutocompleteModel({
    required this.description,
    required this.placeId,
  });

  factory PlaceAutocompleteModel.fromJson(Map<String, dynamic> json) {
    return PlaceAutocompleteModel(
      description: json['description'],
      placeId: json['place_id'],
    );
  }
}
