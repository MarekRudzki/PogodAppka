part of 'cities_bloc.dart';

abstract class CitiesState extends Equatable {
  const CitiesState();

  @override
  List<Object> get props => [];
}

class CitiesLoading extends CitiesState {}

class LatestCityLoaded extends CitiesState {
  final CityModel cityModel;

  const LatestCityLoaded({required this.cityModel});

  @override
  List<Object> get props => [cityModel];
}

class RecentSearchesLoaded extends CitiesState {
  final List<CityModel> recentSearches;

  const RecentSearchesLoaded(this.recentSearches);

  @override
  List<Object> get props => [recentSearches];
}
