import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:open_weather_example_flutter/src/api/api.dart';
import 'package:open_weather_example_flutter/src/features/weather/data/weather_data.dart';
import 'package:open_weather_example_flutter/src/features/weather/data/forecast_data.dart';
import 'package:open_weather_example_flutter/src/features/weather/data/api_exception.dart';

class HttpWeatherRepository {
  final OpenWeatherMapAPI api;
  final http.Client client;

  HttpWeatherRepository({
    required this.api,
    required this.client,
  });

  Future<WeatherData> getWeather({required String city}) async {
    final Uri url = api.weather(city);
    final response = await client.get(url);

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return WeatherData.fromJson(jsonMap);
    } else if (response.statusCode == 404) {
      throw CityNotFoundException();
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<ForecastData> getForecast({required String city}) async {
    final Uri url = api.forecast(city);
    final response = await client.get(url);

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return ForecastData.fromJson(jsonMap);
    } else {
      throw Exception('Failed to load forecast data');
    }
  }
}
