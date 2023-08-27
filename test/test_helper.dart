import 'package:pogodappka/features/cities/data/models/city_model.dart';
import 'package:pogodappka/features/places/data/models/place_autocomplete_model.dart';
import 'package:pogodappka/features/weather/data/models/daily_weather_data.dart';
import 'package:pogodappka/features/weather/data/models/weather_data.dart';
import 'package:pogodappka/features/weather/data/models/weather_data_hourly.dart';
import 'package:pogodappka/features/weather/data/models/weather_day_length.dart';

final sampleCity = CityModel(name: 'City', placeId: 'qwerty');
final sampleCitiesList = [
  CityModel(
    name: 'Foo',
    placeId: '123',
  ),
  CityModel(
    name: 'Bar',
    placeId: '456',
  ),
  CityModel(
    name: 'Baz',
    placeId: '789',
  ),
];

final sampleWeatherData = WeatherData(
  weatherDataModel: [
    WeatherDataModel(
      dailyWeatherData: const DailyWeatherData(
          cloudCover: 1,
          dateTime: '',
          humidity: 1,
          icon: '',
          precip: 1,
          precipprob: 1,
          pressure: 1,
          severerisk: 1,
          tempMax: 1),
      weatherDataHourly: WeatherDataHourly(hourly: [
        const Hourly(
            datetime: '',
            icon: '',
            precip: 1,
            precipprob: 1,
            severerisk: 1,
            temp: 1,
            winddir: 1,
            windspeed: 1)
      ]),
      weatherDayLength:
          const WeatherDayLength(sunrise: '12:00:00', sunset: '12:00:00'),
    ),
  ],
);

final Map<String, dynamic> sampleWeatherJson = {
  'days': [
    {
      'cloudcover': 1,
      'datetime': '',
      'humidity': 1,
      'icon': '',
      'precip': 1,
      'precipprob': 1,
      'pressure': 1,
      'severerisk': 1,
      'tempmax': 1.0,
      'hours': [
        {
          'datetime': '',
          'icon': '',
          'precip': 1,
          'precipprob': 1,
          'severerisk': 1,
          'temp': 1.0,
          'winddir': 1,
          'windspeed': 1,
        }
      ],
      'sunrise': '12:00:00',
      'sunset': '12:00:00',
    }
  ],
};

List<bool> getExpandedList({required int index, required bool initialStatus}) {
  final defaultList = List.generate(15, (_) => false);
  defaultList[index + 2] = !initialStatus;
  return defaultList;
}

final double sampleLatitude = 41.303921;
final double sampleLongitude = -81.901693;

final List<PlaceAutocompleteModel> autocompletePlaces = [
  PlaceAutocompleteModel(description: 'city1', placeId: 'cityId1'),
  PlaceAutocompleteModel(description: 'city2', placeId: 'cityId2'),
  PlaceAutocompleteModel(description: 'city3', placeId: 'cityId3')
];

final autocompleteReposnse = {
  'predictions': [
    {
      'description': 'city1',
      'place_id': 'cityId1',
    },
    {
      'description': 'city2',
      'place_id': 'cityId2',
    },
    {
      'description': 'city3',
      'place_id': 'cityId3',
    }
  ],
};
