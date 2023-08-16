class PlaceCooridnatesModel {
  final double latitude;
  final double longitude;

  PlaceCooridnatesModel(
    this.latitude,
    this.longitude,
  );

  factory PlaceCooridnatesModel.fromJson(Map<String, dynamic> json) {
    return PlaceCooridnatesModel(
        (((json['result'] as Map<String, dynamic>)['geometry']
                as Map<String, dynamic>)['location']
            as Map<String, dynamic>)['lat'] as double,
        (((json['result'] as Map<String, dynamic>)['geometry']
                as Map<String, dynamic>)['location']
            as Map<String, dynamic>)['lng'] as double);
  }
}
