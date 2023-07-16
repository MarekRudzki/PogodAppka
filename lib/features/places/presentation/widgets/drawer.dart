import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pogodappka/features/places/data/models/autocomplete_prediction.dart';
import 'package:pogodappka/features/places/data/models/place_autocomplete_response.dart';
import 'package:pogodappka/features/places/presentation/widgets/location_list_tile.dart';
import 'package:pogodappka/features/places/presentation/widgets/network_utility.dart';

class HomePageDrawer extends StatefulWidget {
  const HomePageDrawer({super.key});

  @override
  State<HomePageDrawer> createState() => _HomePageDrawerState();
}

var apiKey = dotenv.env['GP_Key'];
List<AutocompletePrediction> placePredictions = [];

//TODO add BLoC
class _HomePageDrawerState extends State<HomePageDrawer> {
  @override
  Widget build(BuildContext context) {
    void placeAutocomplete(String query) async {
      Uri uri = Uri.https(
        "maps.googleapis.com",
        'maps/api/place/autocomplete/json',
        {
          "input": query,
          "key": apiKey,
        },
      );
      String? response = await NetworkUtility.fetchUrl(uri);
      if (response != null) {
        PlaceAutocompleteResponse result =
            PlaceAutocompleteResponse.parseAutocompleteResult(response);

        if (result.predictions != null) {
          setState(() {
            placePredictions = result.predictions!;
          });
        }
      }
    }

    return Drawer(
      backgroundColor: const Color.fromARGB(255, 34, 123, 196),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) {
                placeAutocomplete(value);
              },
              textInputAction: TextInputAction.search,
              decoration: const InputDecoration(
                hintText: 'Wpisz miasto...',
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(
                  Icons.location_city,
                  color: Colors.white,
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
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton.icon(
                onPressed: () {},
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
                itemCount: placePredictions.length,
                itemBuilder: (context, index) => LocationListTile(
                  location: placePredictions[index].description!,
                  callback: () {
                    print(placePredictions[index].description!);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
