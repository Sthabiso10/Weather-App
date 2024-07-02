import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:open_weather_example_flutter/src/api/api.dart';
import 'package:open_weather_example_flutter/src/features/weather/data/http_repositry.dart';
import 'package:open_weather_example_flutter/src/features/weather/data/weather_data.dart';
import 'package:open_weather_example_flutter/src/features/weather/data/api_exception.dart';

class MockHttpClient extends Mock implements http.Client {}

// Define a mock response for the weather data
const encodedWeatherJsonResponse = """
{
  "coord": {"lon": -122.08, "lat": 37.39},
  "weather": [{"id": 800, "main": "Clear", "description": "clear sky", "icon": "01d"}],
  "main": {"temp": 282.55, "feels_like": 281.86, "temp_min": 280.37, "temp_max": 284.26, "pressure": 1023, "humidity": 100},
  "name": "Mountain View",
  "cod": 200
}
""";

void main() {
  // Setup for tests
  setUpAll(() {
    registerFallbackValue(Uri());
  });

  test('repository with mocked http client, success', () async {
    final mockHttpClient = MockHttpClient();
    final api = OpenWeatherMapAPI('apiKey');
    final weatherRepository =
        HttpWeatherRepository(api: api, client: mockHttpClient);

    // Mock the http response for weather data
    when(() => mockHttpClient.get(any())).thenAnswer(
      (_) async => http.Response(encodedWeatherJsonResponse, 200),
    );

    // Fetch weather
    final weather = await weatherRepository.getWeather(city: 'Mountain View');

    expect(weather.city, 'Mountain View');
    expect(weather.temp, 282.55);
    expect(weather.minTemp, 280.37);
    expect(weather.maxTemp, 284.26);
    expect(weather.iconUrl, 'http://openweathermap.org/img/wn/01d.png');
  });

  test('repository with mocked http client, failure', () async {
    final mockHttpClient = MockHttpClient();
    final api = OpenWeatherMapAPI('apiKey');
    final weatherRepository =
        HttpWeatherRepository(api: api, client: mockHttpClient);

    // Mock the http response for not found (404)
    when(() => mockHttpClient.get(any())).thenAnswer(
      (_) async => http.Response('Not Found', 404),
    );

    // Make sure to check if api returns CityNotFoundException
    expect(
      () async => await weatherRepository.getWeather(city: 'InvalidCity'),
      throwsA(isA<CityNotFoundException>()),
    );
  });

  // Add more tests as needed...
}
