import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_geocoder/location_geocoder.dart';
import 'package:pogodappka/features/cities/data/models/city_model.dart';

class GeolocationRemoteDataSource {
  Future<CityModel> getCurrentGeolocation() async {
    var apiKey = dotenv.env['GP_Key'];
    final LocatitonGeocoder geocoder = LocatitonGeocoder(apiKey.toString());

    try {
      final currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
        timeLimit: const Duration(seconds: 5),
      );

      final response = await Dio().get<Map<String, dynamic>>(
          'https://maps.googleapis.com/maps/api/geocode/json?&latlng=${currentPosition.latitude}%2C${currentPosition.longitude}&key=$apiKey');
      var responseList = response.data!['results'] as List<dynamic>;
      final convertedResponse =
          responseList.map((e) => e as Map<String, dynamic>).toList();
      final String placeId = convertedResponse.first['place_id'] as String;

      final address = await geocoder.findAddressesFromCoordinates(
        Coordinates(currentPosition.latitude, currentPosition.longitude),
      );
      return CityModel(
        name: address.first.locality!,
        placeId: placeId,
      );
    } catch (error) {
      throw Exception(
          'Obecnie nie można zlokalizować Twojej pozycji. Spróbuj wyszukać ją ręcznie');
    }
  }
}
