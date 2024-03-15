// weather_page.dart
// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_print

import "package:flutter/material.dart";
import "package:lottie/lottie.dart";
import "package:weather_app/models/weather_model.dart";
import "package:weather_app/services/weather_service.dart";

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('API_KEY');
  Weather? _weather;

  _fetchWeather() async {
    try {
      final location = await _weatherService.getCurrentLocation();
      final latitude = location['latitude'];
      final longitude = location['longitude'];

      final weather = await _weatherService.getWeather(latitude, longitude);
      setState(() {
        _weather = weather;   
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDEDEDE),
      appBar: AppBar(
        backgroundColor: Color(0xFFDEDEDE),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_pin,
                size: 26,
                color: Colors.grey[700],
              ),
              const SizedBox(height: 15,),
              Text(
                _weather?.cityName.toUpperCase() ?? "loading city...",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF777777),
                ),
              ),
              const SizedBox(height: 100,),
              Lottie.asset(
                getWeatherAnimation(_weather?.mainCondition),
                height: 200,
              ),
              const SizedBox(height: 100,),
              Text(
                '${_weather?.temperature.round()}°',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF363636),
                ),
              ),
          
              // Text(_weather?.mainCondition ?? ""),
            ],
          ),
        ),
      ),
    );
  }
}