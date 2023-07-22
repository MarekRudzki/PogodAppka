import 'package:location_geocoder/location_geocoder.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';

class GeolocationRepository {
  Future<String> getCurrentLocation() async {
    var apiKey = dotenv.env['GP_Key'];
    final LocatitonGeocoder geocoder = LocatitonGeocoder(apiKey.toString());

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Lokalizacja jest wyłączona');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        throw Exception(
            'Lokalizacja jest wyłączona na stałe, nie można zlokalizować Twojej pozycji');
      }
    }
    try {
      final currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
        timeLimit: const Duration(seconds: 5),
      );

      final address = await geocoder.findAddressesFromCoordinates(
        Coordinates(currentPosition.latitude, currentPosition.longitude),
      );
      return address.first.locality!;
    } catch (error) {
      throw Exception(
          'Obecnie nie można zlokalizować Twojej pozycji. Spróbuj wyszukać ją ręcznie');
    }
  }
}
