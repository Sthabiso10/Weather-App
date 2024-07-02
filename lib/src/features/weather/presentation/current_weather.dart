import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:open_weather_example_flutter/src/features/weather/application/providers.dart';

class CurrentWeather extends StatelessWidget {
  final bool isFahrenheit;

  const CurrentWeather({Key? key, required this.isFahrenheit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentWeather =
        context.watch<WeatherProvider>().currentWeatherProvider;
    final city = context.watch<WeatherProvider>().city;

    if (currentWeather == null) {
      return CircularProgressIndicator();
    }

    // Function to convert temperature to Fahrenheit
    double toFahrenheit(double celsius) => (celsius * 9 / 5) + 32;

    // To see which temperature to show based on the tapping of the button
    double displayedTemp =
        isFahrenheit ? toFahrenheit(currentWeather.temp) : currentWeather.temp;

    // Displayed high and low temperatures
    double displayedHighTemp = isFahrenheit
        ? toFahrenheit(currentWeather.maxTemp)
        : currentWeather.maxTemp;
    double displayedLowTemp = isFahrenheit
        ? toFahrenheit(currentWeather.minTemp)
        : currentWeather.minTemp;

    return Column(
      children: [
        Text(
          city,
          style: TextStyle(fontSize: 30),
        ),
        Text(
          '${displayedTemp.toStringAsFixed(0)} ${isFahrenheit ? '°F' : '°C'}',
          style: TextStyle(fontSize: 25),
        ),
        Image.network(
          currentWeather.iconUrl,
          height: 90,
          width: 90,
          fit: BoxFit.contain,
        ),
        // Adjust the spacing as needed
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'H: ${displayedHighTemp.toStringAsFixed(0)} ${isFahrenheit ? '°F' : '°C'}',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(width: 10),
            Text(
              'L: ${displayedLowTemp.toStringAsFixed(0)} ${isFahrenheit ? '°F' : '°C'}',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ],
    );
  }
}
