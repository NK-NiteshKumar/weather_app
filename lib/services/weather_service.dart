// weather_service.dart
// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = 'http://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(double latitude, double longitude) async {
    final response = await http.get(Uri.parse(
        '$BASE_URL?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error getting weather for the provided coordinates');
    }
  }

  Future<Map<String, dynamic>> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    String? city = placemarks.isNotEmpty ? placemarks[0].locality : null;
    double latitude = position.latitude;
    double longitude = position.longitude;

    return {
      'cityName': city,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}