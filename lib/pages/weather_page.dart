// weather_page.dart
import "package:flutter/material.dart";
import "package:weather_app/models/weather_model.dart";
import "package:weather_app/services/weather_service.dart";

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('11236d5df941c8dc5b2be0a864edd101');
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

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "loading city..."),
            Text('${_weather?.temperature.round()}°C')
          ],
        ),
      ),
    );
  }
}