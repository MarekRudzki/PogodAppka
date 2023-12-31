part of 'autocomplete_bloc.dart';

abstract class AutocompleteState extends Equatable {
  const AutocompleteState();

  @override
  List<Object> get props => [];
}

class AutocompleteLoading extends AutocompleteState {
  @override
  List<Object> get props => [];
}

class AutocompleteLoaded extends AutocompleteState {
  final List<PlaceAutocompleteModel> places;

  const AutocompleteLoaded({required this.places});

  @override
  List<Object> get props => [places];
}
