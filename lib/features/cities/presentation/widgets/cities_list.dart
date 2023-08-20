import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pogodappka/features/cities/data/models/city_model.dart';
import 'package:pogodappka/features/cities/presentation/blocs/cities/cities_bloc.dart';
import 'package:pogodappka/features/place_coordinates/presentation/blocs/place_coordinates/place_coordinates_bloc.dart';
import 'package:pogodappka/features/places/presentation/blocs/autocomplete/autocomplete_bloc.dart';
import 'package:pogodappka/features/places/presentation/widgets/location_list_tile.dart';
import 'package:pogodappka/features/weather/presentation/blocs/fourteen_day_forecast/fourteen_day_forecast_bloc.dart';
import 'package:pogodappka/features/weather/presentation/blocs/weather/weather_bloc.dart';
import 'package:pogodappka/features/weather/presentation/views/home_screen.dart';
import 'package:pogodappka/utils/l10n/localization.dart';

class CitiesList extends StatelessWidget {
  const CitiesList({super.key});

  @override
  Widget build(BuildContext context) {
    int index = 0;
    void getId({
      required int id,
    }) {
      index = id;
    }

    return BlocBuilder<AutocompleteBloc, AutocompleteState>(
      builder: (context, autocompleteState) {
        if (autocompleteState is AutocompleteLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (autocompleteState is AutocompleteLoaded) {
          if (autocompleteState.places.isNotEmpty) {
            return BlocListener<WeatherBloc, WeatherState>(
              listener: (context, weatherState) {
                final String placeId = autocompleteState.places[index].placeId;
                final String adress =
                    autocompleteState.places[index].description;
                final String city;
                if (adress.contains(',')) {
                  city = adress.substring(0, adress.indexOf(','));
                } else {
                  city = adress.substring(0, adress.indexOf(' '));
                }
                if (weatherState is WeatherLoaded) {
                  context.read<CitiesBloc>().add(AddLatestCity(
                      cityModel: CityModel(name: city, placeId: placeId)));
                  context.read<PlaceCoordinatesBloc>().add(
                      FetchPlaceCoordinates(
                          placeId: autocompleteState.places[index].placeId));
                  context
                      .read<FourteenDayForecastBloc>()
                      .add(LoadForecast(weatherData: weatherState.weatherData));
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                } else if (weatherState is WeatherError) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  showModalBottomSheet(
                    context: context,
                    useRootNavigator: true,
                    barrierColor: const Color.fromARGB(62, 3, 2, 2),
                    builder: (BuildContext context) {
                      return Container(
                        color: const Color.fromARGB(255, 54, 202, 184),
                        padding: const EdgeInsets.all(12),
                        child: Wrap(
                          children: [
                            Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Center(
                                      child: Text(
                                        context.l10n.cityNotAvailable(city),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                        overflow: TextOverflow.visible,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: const Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
              },
              child: Expanded(
                child: ListView.builder(
                  itemCount: autocompleteState.places.length,
                  itemBuilder: (context, index) => LocationListTile(
                    location: autocompleteState.places[index].description,
                    callback: () {
                      final String adress =
                          autocompleteState.places[index].description;
                      final String city;
                      if (adress.contains(',')) {
                        city = adress.substring(0, adress.indexOf(','));
                      } else {
                        city = adress.substring(0, adress.indexOf(' '));
                      }

                      context.read<WeatherBloc>().add(FetchWeather(city: city));

                      getId(id: index);
                    },
                  ),
                ),
              ),
            );
          } else {
            return BlocBuilder<CitiesBloc, CitiesState>(
              builder: (context, state) {
                if (state is CitiesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is RecentSearchesLoaded) {
                  final cities = state.recentSearches.reversed.toList();
                  return Expanded(
                    child: ListView.builder(
                      itemCount: cities.length,
                      itemBuilder: (context, index) => LocationListTile(
                        location: cities[index].name,
                        callback: () {
                          final String city = cities[index].name;
                          final String placeId = cities[index].placeId;

                          context
                              .read<WeatherBloc>()
                              .add(FetchWeather(city: city));
                          context.read<CitiesBloc>().add(AddLatestCity(
                              cityModel:
                                  CityModel(name: city, placeId: placeId)));
                          context
                              .read<PlaceCoordinatesBloc>()
                              .add(FetchPlaceCoordinates(placeId: placeId));
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ));
                        },
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            );
          }
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
