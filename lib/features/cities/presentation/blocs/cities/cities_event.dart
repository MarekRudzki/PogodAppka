part of 'cities_bloc.dart';

abstract class CitiesEvent extends Equatable {
  const CitiesEvent();

  @override
  List<Object> get props => [];
}

class LoadLatestCity extends CitiesEvent {}

class LoadRecentSearches extends CitiesEvent {}

class AddLatestCity extends CitiesEvent {
  final CityModel cityModel;

  const AddLatestCity({required this.cityModel});

  @override
  List<Object> get props => [cityModel];
}
