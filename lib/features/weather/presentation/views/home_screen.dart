// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

// Project imports:
import 'package:pogodappka/features/cities/presentation/blocs/cities/cities_bloc.dart';
import 'package:pogodappka/features/language/presentation/widgets/language_picker.dart';
import 'package:pogodappka/features/places/presentation/blocs/autocomplete/autocomplete_bloc.dart';
import 'package:pogodappka/features/weather/presentation/blocs/fourteen_day_forecast/fourteen_day_forecast_bloc.dart';
import 'package:pogodappka/features/weather/presentation/blocs/weather/weather_bloc.dart';
import 'package:pogodappka/features/weather/presentation/widgets/forecast/forecast_details.dart';
import 'package:pogodappka/features/weather/presentation/widgets/forecast/fourteen_day_forecast.dart';
import 'package:pogodappka/features/weather/presentation/widgets/home_screen_drawer.dart';
import 'package:pogodappka/utils/l10n/localization.dart';
import 'package:pogodappka/utils/no_network.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  // ignore: unused_field
  late StreamSubscription<InternetConnectionStatus> _internetSubscription;
  bool hasInternet = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
    );

    _internetSubscription =
        InternetConnectionChecker().onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.disconnected) {
        setState(() {
          hasInternet = false;
        });
      } else {
        setState(() {
          hasInternet = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _internetSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _tabController.index = 0;
    return SafeArea(
      child: hasInternet
          ? Scaffold(
              backgroundColor: const Color.fromARGB(255, 54, 202, 184),
              endDrawerEnableOpenDragGesture: false,
              endDrawer: GestureDetector(
                onHorizontalDragUpdate: (_) {},
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: const HomePageDrawer(),
                ),
              ),
              appBar: AppBar(
                leading: const LanguagePicker(),
                centerTitle: true,
                title: BlocBuilder<CitiesBloc, CitiesState>(
                  builder: (context, state) {
                    if (state is LatestCityLoaded) {
                      return Text(
                        state.cityModel.name,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                backgroundColor: const Color.fromARGB(255, 8, 180, 160),
                elevation: 0,
                actions: [
                  Builder(
                    builder: (context) {
                      return IconButton(
                        onPressed: () {
                          Scaffold.of(context).openEndDrawer();
                          context
                              .read<AutocompleteBloc>()
                              .add(ClearAutocomplete());
                        },
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 26,
                        ),
                      );
                    },
                  ),
                ],
                bottom: TabBar(
                  controller: _tabController,
                  labelColor: Colors.white,
                  indicatorColor: Colors.white,
                  tabs: [
                    Tab(text: context.l10n.today),
                    Tab(text: context.l10n.tomorrow),
                    Tab(text: context.l10n.fourteenDays),
                  ],
                ),
              ),
              body: MultiBlocListener(
                listeners: [
                  BlocListener<WeatherBloc, WeatherState>(
                    listener: (context, weatherState) {
                      if (weatherState is WeatherLoaded) {
                        context.read<FourteenDayForecastBloc>().add(
                            LoadForecast(
                                weatherData: weatherState.weatherData));
                      }
                    },
                  ),
                  BlocListener<CitiesBloc, CitiesState>(
                    listener: (context, citiesState) {
                      if (citiesState is LatestCityLoaded) {
                        context.read<WeatherBloc>().add(
                            FetchWeather(city: citiesState.cityModel.name));
                      }
                    },
                  )
                ],
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    ForecastDetails(
                      day: 0,
                    ),
                    ForecastDetails(
                      day: 1,
                    ),
                    FourteenDayForecast(),
                  ],
                ),
              ),
            )
          : const NoNetwork(),
    );
  }
}
