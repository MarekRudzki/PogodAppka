import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pogodappka/features/places/presentation/blocs/geolocation/geolocation_bloc.dart';
import 'package:pogodappka/utils/l10n/localization.dart';

class CurrentLocation extends StatelessWidget {
  const CurrentLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<GeolocationBloc, GeolocationState>(
      listener: (context, state) {
        if (state is GeolocationLoaded) {
          Navigator.of(context).pop();
        }
        if (state is GeolocationError) {
          showModalBottomSheet(
            context: context,
            barrierColor: const Color.fromARGB(62, 3, 2, 2),
            builder: (BuildContext context) {
              Future.delayed(
                const Duration(seconds: 3),
                () {
                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                },
              );
              return Container(
                color: const Color.fromARGB(255, 54, 202, 184),
                padding: const EdgeInsets.all(12),
                child: Wrap(
                  children: [
                    Center(
                      child: Text(
                        showGeolocationError(
                          errorMessage: state.errorMessage,
                          context: context,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.visible,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        }
      },
      child: Column(
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
            child: BlocBuilder<GeolocationBloc, GeolocationState>(
              builder: (context, state) {
                if (state is GeolocationLoading) {
                  return Container(
                    color: const Color.fromARGB(255, 60, 212, 194),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return ElevatedButton.icon(
                    onPressed: () async {
                      context.read<GeolocationBloc>().add(LoadGeolocation());
                    },
                    icon: const Icon(
                      Icons.gps_fixed,
                      size: 26,
                      color: Colors.white,
                    ),
                    label: Text(
                      context.l10n.useGeolocation,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 60, 212, 194),
                      elevation: 4,
                    ),
                  );
                }
              },
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
      ),
    );
  }
}

String showGeolocationError({
  required String errorMessage,
  required BuildContext context,
}) {
  if (errorMessage == 'location-off') {
    return context.l10n.locationDisabled;
  } else if (errorMessage == 'location-deniedForever') {
    return context.l10n.locationDisabledForever;
  } else {
    return context.l10n.cannotGeolocate;
  }
}
