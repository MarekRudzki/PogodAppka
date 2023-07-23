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
              Navigator.of(context).pop();
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
