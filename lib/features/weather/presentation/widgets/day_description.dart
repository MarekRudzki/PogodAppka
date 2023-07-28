import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldtime/worldtime.dart';

import 'package:pogodappka/features/place_coordinates/presentation/blocs/place_coordinates/place_coordinates_bloc.dart';

class DayDescription extends StatelessWidget {
  const DayDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceCoordinatesBloc, PlaceCoordinatesState>(
      builder: (context, state) {
        if (state is PlaceCoordinatesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PlaceCoordinatesLoaded) {
          final worldtimePlugin = Worldtime();
          return FutureBuilder(
            future: worldtimePlugin.timeByLocation(
              latitude: state.placeCooridnatesModel.latitude,
              longitude: state.placeCooridnatesModel.longitude,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return LocalDateTime(
                  localDateTime: snapshot.data!,
                );
              } else {
                return const Text('Nie można wyświetlić daty i godziny');
              }
            },
          );
        } else {
          return const Text('Nie można wyświetlić daty i godziny');
        }
      },
    );
  }
}

class LocalDateTime extends StatelessWidget {
  final DateTime localDateTime;
  const LocalDateTime({
    super.key,
    required this.localDateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          toBeginningOfSentenceCase(DateFormat('d MMMM yyyy', 'pl')
              .format(localDateTime)
              .toString())!,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          toBeginningOfSentenceCase(
              DateFormat('EEEE', 'pl').format(localDateTime).toString())!,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          displayTime(
            hour: localDateTime.hour.toString(),
            minute: localDateTime.minute.toString(),
          ),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ],
    );
  }
}

String displayTime({required String hour, required String minute}) {
  final String newHour = int.parse(hour) < 10 ? '0$hour' : hour;
  final String newMinute = int.parse(minute) < 10 ? '0$minute' : minute;

  return '$newHour:$newMinute';
}
