// weather_model.dart
class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final double cityLatitude;
  final double cityLongitude;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.cityLatitude,
    required this.cityLongitude,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      cityLatitude: json['coord']['lat'].toDouble(),
      cityLongitude: json['coord']['lon'].toDouble(),
    );
  }
}