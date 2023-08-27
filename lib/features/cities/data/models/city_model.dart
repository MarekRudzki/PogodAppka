import 'package:equatable/equatable.dart';

class CityModel extends Equatable {
  final String name;
  final String placeId;

  CityModel({
    required this.name,
    required this.placeId,
  });

  @override
  List<Object> get props => [name, placeId];
}
