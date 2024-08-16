import 'package:flutter/material.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  Map<String, dynamic>? _weatherData;
  String _cityName = 'London';

  Map<String, dynamic>? get weatherData => _weatherData;
  String get cityName => _cityName;

  void setCityName(String city) {
    _cityName = city;
    notifyListeners();
  }

  Future<void> fetchWeather() async {
    _weatherData = await _weatherService.fetchWeather(_cityName);
    notifyListeners();
  }
}
