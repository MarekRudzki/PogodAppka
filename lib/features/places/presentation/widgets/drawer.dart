import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:location_geocoder/location_geocoder.dart';
import 'package:pogodappka/features/places/presentation/blocs/autocomplete/autocomplete_bloc.dart';

import 'package:pogodappka/features/places/presentation/widgets/location_list_tile.dart';

class HomePageDrawer extends StatelessWidget {
  const HomePageDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: double.infinity,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 49, 228, 225),
              Color.fromARGB(255, 66, 200, 113),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: BlocBuilder<AutocompleteBloc, AutocompleteState>(
            builder: (context, state) {
              if (state is AutocompleteLoading) {
                return const CircularProgressIndicator();
              } else if (state is AutocompleteLoaded) {
                return Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) {
                              context
                                  .read<AutocompleteBloc>()
                                  .add(LoadAutocomplete(searchInput: value));
                            },
                            textInputAction: TextInputAction.search,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              hintText: 'Wpisz miasto...',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              suffixIcon: Icon(
                                Icons.location_city,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Divider(
                        color: Colors.white,
                        thickness: 1,
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          var apiKey = dotenv.env['GP_Key'];

                          final LocatitonGeocoder geocoder =
                              LocatitonGeocoder(apiKey.toString());
                          final address =
                              await geocoder.findAddressesFromCoordinates(
                                  Coordinates(49.391925, 20.097368));
                          print(address.first.locality);
                        },
                        icon: const Icon(
                          Icons.gps_fixed,
                          size: 26,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Użyj Twojej lokalizacji',
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Divider(
                        color: Colors.white,
                        thickness: 1,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.places.length,
                        itemBuilder: (context, index) => LocationListTile(
                          location: state.places[index].description,
                          callback: () {
                            print(state.places[index].description);
                          },
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return const Text('Something went wrong');
              }
            },
          ),
        ),
      ),
    );
  }
}
