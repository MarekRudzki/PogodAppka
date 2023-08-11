import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pogodappka/features/weather/presentation/blocs/bloc/fifteen_day_forecast_bloc.dart';
import 'package:pogodappka/features/weather/presentation/widgets/forecast/forecast_details.dart';

class FifteenDayForecast extends StatelessWidget {
  const FifteenDayForecast({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FifteenDayForecastBloc, FifteenDayForecastState>(
      builder: (context, state) {
        if (state is FifteenDayForecastLoading) {
          return Center(
            child: Image.asset(
              'assets/waiting_animation.gif',
              width: 200,
            ),
          );
        }
        if (state is FifteenDayForecastLoaded) {
          return SingleChildScrollView(
            child: ExpansionPanelList(
              expansionCallback: (index, isExpanded) {
                context.read<FifteenDayForecastBloc>().add(
                      ExpandTile(
                        tileIndex: index,
                        isExpanded: isExpanded,
                        weatherData: state.weatherData,
                      ),
                    );
              },
              animationDuration: const Duration(seconds: 2),
              children: [
                for (int i = 2; i < 15; i++)
                  ExpansionPanel(
                    backgroundColor: const Color.fromARGB(255, 54, 202, 184),
                    isExpanded: state.isExpanded[i],
                    canTapOnHeader: true,
                    headerBuilder: (context, isExpanded) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                toBeginningOfSentenceCase(
                                  DateFormat('EEEE', 'pl').format(
                                      DateTime.parse(state
                                          .weatherData
                                          .weatherDataModel[i]
                                          .dailyWeatherData
                                          .dateTime)),
                                ).toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                toBeginningOfSentenceCase(
                                  DateFormat('d MMMM', 'pl').format(
                                      DateTime.parse(state
                                          .weatherData
                                          .weatherDataModel[i]
                                          .dailyWeatherData
                                          .dateTime)),
                                ).toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            '${state.weatherData.weatherDataModel[i].dailyWeatherData.tempMax} ℃',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(width: 40),
                          Image.asset(
                            showWeatherIcon(
                              severerisk: state.weatherData.weatherDataModel[i]
                                  .dailyWeatherData.severerisk,
                              icon: state.weatherData.weatherDataModel[i]
                                  .dailyWeatherData.icon,
                            ),
                            scale: 8.5,
                          ),
                          const SizedBox(width: 15),
                        ],
                      ),
                    ),
                    body: Visibility(
                      visible: state.isExpanded[i],
                      child: AnimatedOpacity(
                        opacity: state.isExpanded[i] ? 1 : 0,
                        curve: Curves.fastOutSlowIn,
                        duration: const Duration(seconds: 2),
                        child: ForecastDetails(day: i),
                      ),
                    ),
                  ),
              ],
            ),
          );
        } else {
          return const Text('Nie można załadować pogody');
        }
      },
    );
  }
}

String showWeatherIcon({
  required int severerisk,
  required String icon,
}) {
  if (severerisk > 30) {
    return 'assets/storm.png';
  } else {
    return 'assets/$icon.png';
  }
}
