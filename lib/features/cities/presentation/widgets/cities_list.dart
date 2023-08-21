// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:pogodappka/features/cities/presentation/widgets/saved_cities.dart';
import 'package:pogodappka/features/cities/presentation/widgets/searched_cities.dart';
import 'package:pogodappka/features/places/presentation/blocs/autocomplete/autocomplete_bloc.dart';

class CitiesList extends StatelessWidget {
  const CitiesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AutocompleteBloc, AutocompleteState>(
      builder: (context, autocompleteState) {
        if (autocompleteState is AutocompleteLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (autocompleteState is AutocompleteLoaded) {
          return autocompleteState.places.isNotEmpty
              ? SearchedCities(places: autocompleteState.places)
              : const SavedCities();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
