import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:pogodappka/features/cities/presentation/blocs/cities/cities_bloc.dart';
import 'package:pogodappka/features/places/presentation/blocs/autocomplete/autocomplete_bloc.dart';
import 'package:pogodappka/features/weather/presentation/widgets/forecast/fifteen_day_forecast.dart';
import 'package:pogodappka/features/weather/presentation/widgets/forecast/forecast_details.dart';
import 'package:pogodappka/features/weather/presentation/widgets/home_screen_drawer.dart';
import 'package:pogodappka/utils/no_network.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  // ignore: unused_field
  late StreamSubscription _internetSubscription;
  bool hasInternet = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 0,
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: hasInternet
          ? Scaffold(
              backgroundColor: const Color.fromARGB(255, 54, 202, 184),
              endDrawer: const HomePageDrawer(),
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(95),
                child: AppBar(
                  centerTitle: true,
                  title: BlocBuilder<CitiesBloc, CitiesState>(
                    builder: (context, state) {
                      if (state is CitiesLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is LatestCityLoaded) {
                        return Text(
                          state.cityModel.name,
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        );
                      } else {
                        return const Text('Błąd! Prognoza niedostępna');
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
                    tabs: const [
                      Tab(text: 'DZISIAJ'),
                      Tab(text: 'JUTRO'),
                      Tab(text: '15 DNI'),
                    ],
                  ),
                ),
              ),
              body: TabBarView(
                controller: _tabController,
                children: const [
                  ForecastDetails(
                    day: 0,
                  ),
                  ForecastDetails(
                    day: 1,
                  ),
                  FifteenDayForecast(),
                ],
              ),
            )
          : const NoNetwork(),
    );
  }
}
