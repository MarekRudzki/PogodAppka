part of 'cities_bloc.dart';

abstract class CitiesState extends Equatable {
  const CitiesState();

  @override
  List<Object> get props => [];
}

class CitiesLoading extends CitiesState {}

class LatestCityLoaded extends CitiesState {
  final String city;

  const LatestCityLoaded(this.city);

  @override
  List<Object> get props => [city];
}

class RecentSearchesLoaded extends CitiesState {
  final List<String> recentSearches;

  const RecentSearchesLoaded(this.recentSearches);

  @override
  List<Object> get props => [recentSearches];
}

class CitiesError extends CitiesState {}
