import 'package:open_weather_example_flutter/src/features/weather/data/weather_data.dart';

class ForecastData {
  final List<WeatherData> hourlyForecasts;

  ForecastData({required this.hourlyForecasts});

  factory ForecastData.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? list = json['list'] as List<dynamic>?;

    if (list == null) {
      throw Exception('Failed to parse forecast data');
    }

    List<WeatherData> forecasts =
        list.map((item) => WeatherData.fromJson(item)).toList();
    return ForecastData(hourlyForecasts: forecasts);
  }

  // Getter for accessing forecast
  List<WeatherData> get forecast => hourlyForecasts;
}
