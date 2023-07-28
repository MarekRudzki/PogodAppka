class PlaceCooridnatesModel {
  final double latitude;
  final double longitude;

  PlaceCooridnatesModel(
    this.latitude,
    this.longitude,
  );

  factory PlaceCooridnatesModel.fromJson(Map<String, dynamic> json) {
    return PlaceCooridnatesModel(
      json['result']['geometry']['location']['lat'],
      json['result']['geometry']['location']['lng'],
    );
  }
}
