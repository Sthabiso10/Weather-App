import 'package:flutter/material.dart';
import 'package:open_weather_example_flutter/src/constants/app_colors.dart';
import 'package:open_weather_example_flutter/src/features/weather/application/providers.dart';
import 'package:open_weather_example_flutter/src/features/weather/presentation/forcast_weather.dart';
import 'package:provider/provider.dart';
import 'city_search_box.dart';
import 'current_weather.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key, required this.city});
  final String city;

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  bool _showForecast = false;
  bool _isFahrenheit = false;

  void _toggleTemperatureUnit() {
    setState(() {
      _isFahrenheit = !_isFahrenheit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WeatherProvider(apiKey: '70ed201b1aef7ef15327fa7e566cb591')
        ..city = widget.city
        ..getWeatherData()
        ..getForecastData(),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColors.rainGradient,
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                const CitySearchBox(),
                const SizedBox(height: 10),
                CurrentWeather(isFahrenheit: _isFahrenheit),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showForecast = !_showForecast;
                    });
                  },
                  child:
                      Text(_showForecast ? 'Hide Forecast' : 'Show Forecast'),
                ),
                if (_showForecast) ForecastWeather(isFahrenheit: _isFahrenheit),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _toggleTemperatureUnit,
                  child: Text(_isFahrenheit ? 'Switch to °C' : 'Switch to °F'),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
