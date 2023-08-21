// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:pogodappka/features/cities/data/models/city_model.dart';
import 'package:pogodappka/features/cities/presentation/blocs/cities/cities_bloc.dart';
import 'package:pogodappka/features/place_coordinates/presentation/blocs/place_coordinates/place_coordinates_bloc.dart';
import 'package:pogodappka/features/places/data/models/place_autocomplete_model.dart';
import 'package:pogodappka/features/places/presentation/widgets/location_list_tile.dart';
import 'package:pogodappka/features/weather/presentation/blocs/fourteen_day_forecast/fourteen_day_forecast_bloc.dart';
import 'package:pogodappka/features/weather/presentation/blocs/weather/weather_bloc.dart';
import 'package:pogodappka/features/weather/presentation/views/home_screen.dart';
import 'package:pogodappka/utils/l10n/localization.dart';

class SearchedCities extends StatelessWidget {
  final List<PlaceAutocompleteModel> places;

  const SearchedCities({
    required this.places,
  });

  @override
  Widget build(BuildContext context) {
    int index = 0;
    final String placeId = places[index].placeId;
    final String adress = places[index].description;
    final String city;

    if (adress.contains(',')) {
      city = adress.substring(0, adress.indexOf(','));
    } else {
      city = adress.substring(0, adress.indexOf(' '));
    }

    void getId({
      required int id,
    }) {
      index = id;
    }

    return BlocListener<WeatherBloc, WeatherState>(
      listener: (context, weatherState) {
        if (weatherState is WeatherLoaded) {
          context.read<CitiesBloc>().add(AddLatestCity(
              cityModel: CityModel(name: city, placeId: placeId)));
          context
              .read<PlaceCoordinatesBloc>()
              .add(FetchPlaceCoordinates(placeId: places[index].placeId));
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          itemCount: places.length,
          itemBuilder: (context, index) => LocationListTile(
            location: places[index].description,
            callback: () {
              context.read<WeatherBloc>().add(FetchWeather(city: city));

              getId(id: index);
            },
          ),
        ),
      ),
    );
  }
}
