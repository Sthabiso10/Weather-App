import 'package:flutter/cupertino.dart';
import 'package:open_weather_example_flutter/src/api/api.dart';
import 'package:open_weather_example_flutter/src/api/api_keys.dart';
import 'package:open_weather_example_flutter/src/features/weather/data/forecast_data.dart';
import 'package:open_weather_example_flutter/src/features/weather/data/http_repositry.dart';
import 'package:open_weather_example_flutter/src/features/weather/data/weather_data.dart';
import 'package:http/http.dart' as http;

class WeatherProvider extends ChangeNotifier {
  final String apiKey;
  late HttpWeatherRepository repository;

  WeatherProvider({required this.apiKey}) {
    repository = HttpWeatherRepository(
      api: OpenWeatherMapAPI(apiKey),
      client: http.Client(),
    );
  }

  String city = 'London';
  WeatherData? currentWeatherProvider;
  ForecastData? hourlyWeatherProvider;
  bool isFahrenheit = false;

  Future<void> getWeatherData() async {
    try {
      final weather = await repository.getWeather(city: city);
      currentWeatherProvider = weather;
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching weather: $e');
    }
  }

  Future<void> getForecastData() async {
    try {
      final forecast = await repository.getForecast(city: city);
      hourlyWeatherProvider = forecast;
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching forecast: $e');
    }
  }

  void toggleTemperatureUnit() {
    isFahrenheit = !isFahrenheit;
    notifyListeners();
  }
}
