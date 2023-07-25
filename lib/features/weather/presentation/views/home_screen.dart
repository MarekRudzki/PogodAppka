import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pogodappka/features/cities/presentation/blocs/cities/cities_bloc.dart';
import 'package:pogodappka/features/places/presentation/blocs/autocomplete/autocomplete_bloc.dart';
import 'package:pogodappka/features/weather/presentation/widgets/home_page_drawer.dart';
import 'package:pogodappka/features/weather/presentation/views/fifteen_day_forecast_weather.dart';
import 'package:pogodappka/features/weather/presentation/views/forecast_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 34, 123, 196),
        endDrawer: const HomePageDrawer(),
        appBar: AppBar(
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
                    fontSize: 26,
                    color: Colors.white,
                  ),
                );
              } else {
                return const Text('Coś poszło nie tak');
              }
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                    context.read<AutocompleteBloc>().add(ClearAutocomplete());
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
            tabs: const [
              Tab(
                text: 'DZISIAJ',
              ),
              Tab(text: 'JUTRO'),
              Tab(text: '15 DNI'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            ForecastDetails(),
            ForecastDetails(),
            FifteenDayForecastWeather(),
          ],
        ),
      ),
    );
  }
}
