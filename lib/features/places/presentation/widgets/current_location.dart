import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pogodappka/features/places/presentation/blocs/geolocation/geolocation_bloc.dart';

class CurrentLocation extends StatelessWidget {
  const CurrentLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
            onPressed: () {
              BlocProvider.of<GeolocationBloc>(context).add(LoadGeolocation());
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
      ],
    );
  }
}

// BlocBuilder<GeolocationBloc, GeolocationState>(
//             builder: (context, state) {
//               if (state is GeolocationLoading) {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//               if (state is GeolocationLoaded) {
//                 return ElevatedButton.icon(
//                   onPressed: () async {
//                     // var apiKey = dotenv.env['GP_Key'];

//                     // try {
//                     //   final location = await getCurrentLocation();
//                     //   final LocatitonGeocoder geocoder =
//                     //       LocatitonGeocoder(apiKey.toString());
//                     //   final address = await geocoder
//                     //       .findAddressesFromCoordinates(Coordinates(
//                     //           location.latitude, location.longitude));
//                     //   print(address.first.locality);
//                     // } catch (error) {
//                     //   print(error);
//                     //   ScaffoldMessenger.of(context).showSnackBar(
//                     //     SnackBar(
//                     //       content: Text(
//                     //         error.toString(),
//                     //       ),
//                     //     ),
//                     //   );
//                     // }

//                     // final LocatitonGeocoder geocoder =
//                     //     LocatitonGeocoder(apiKey.toString());
//                     // final address = await geocoder
//                     //     .findAddressesFromCoordinates(Coordinates(
//                     //         location.latitude, location.longitude));
//                     // print(address.first.locality);
//                   },
//                   icon: const Icon(
//                     Icons.gps_fixed,
//                     size: 26,
//                     color: Colors.white,
//                   ),
//                   label: const Text(
//                     'Użyj Twojej lokalizacji',
//                   ),
//                 );
//               } else {
//                 return const Text('Nie można załadować elementu');
//               }
//             },
//           ),