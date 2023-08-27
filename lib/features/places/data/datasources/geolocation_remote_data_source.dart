// // Package imports:
// import 'package:dio/dio.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:injectable/injectable.dart';

// @lazySingleton
// class GeolocationRemoteDataSource {
//   Future<Map<String, dynamic>> getCurrentGeolocation({
//     required String apiKey,
//     required Position currentPosition,
//   }) async {
//     try {
//       final response = await Dio().get<Map<String, dynamic>>(
//           'https://maps.googleapis.com/maps/api/geocode/json?&latlng=${currentPosition.latitude}%2C${currentPosition.longitude}&key=$apiKey');
//       return response.data!;
//     } catch (error) {
//       throw Exception();
//     }
//   }
// }

// Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:location_geocoder/location_geocoder.dart';

@lazySingleton
class GeolocationRemoteDataSource {
  final apiKey = dotenv.env['GP_Key'];

  Future<Position?> getCurrentPosition() async {
    try {
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        throw Exception('location-off');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('location-denied');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        throw Exception('location-deniedForever');
      }
    } catch (error) {
      throw Exception(error);
    }

    final currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
      timeLimit: const Duration(seconds: 5),
    );
    return currentPosition;
  }

  Future<Map<String, dynamic>> getCurrentGeolocation() async {
    try {
      final currentPosition = await getCurrentPosition();
      if (currentPosition == null) {
        throw Exception();
      }

      final response = await Dio().get<Map<String, dynamic>>(
          'https://maps.googleapis.com/maps/api/geocode/json?&latlng=${currentPosition.latitude}%2C${currentPosition.longitude}&key=$apiKey');
      return response.data!;
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<String> getAdress() async {
    final LocatitonGeocoder geocoder = LocatitonGeocoder(apiKey.toString());

    try {
      final currentPosition = await getCurrentPosition();
      if (currentPosition == null) {
        throw Exception();
      }
      final address = await geocoder.findAddressesFromCoordinates(
        Coordinates(currentPosition.latitude, currentPosition.longitude),
      );

      return address.first.locality!;
    } catch (error) {
      throw Exception(error);
    }
  }
}
