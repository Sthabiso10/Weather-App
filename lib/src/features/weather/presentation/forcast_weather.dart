import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:open_weather_example_flutter/src/features/weather/application/providers.dart';
import 'package:open_weather_example_flutter/src/features/weather/data/weather_data.dart';
import 'package:provider/provider.dart';

class ForecastWeather extends StatelessWidget {
  final bool isFahrenheit;

  const ForecastWeather({Key? key, required this.isFahrenheit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final forecast = context.watch<WeatherProvider>().hourlyWeatherProvider;

    if (forecast == null || forecast.hourlyForecasts.isEmpty) {
      return CircularProgressIndicator(); // Putting a loading placeholder for loading state
    }

    // Function to convert temperature to Fahrenheit
    double toFahrenheit(double celsius) => (celsius * 9 / 5) + 32;

    // Map to store weather data for each day of the week
    final Map<int, WeatherData> dailyForecasts = {};

    // Populate the dailyForecasts map with the first occurrence of each day
    for (var weatherData in forecast.hourlyForecasts) {
      final dateTime =
          DateTime.fromMillisecondsSinceEpoch(weatherData.dt * 1000);
      final dayOfWeek = dateTime.weekday;

      if (!dailyForecasts.containsKey(dayOfWeek)) {
        dailyForecasts[dayOfWeek] = weatherData;
      }
    }

    // List of days of the week
    final List<int> daysOfWeek = [
      DateTime.monday,
      DateTime.tuesday,
      DateTime.wednesday,
      DateTime.thursday,
      DateTime.friday,
      DateTime.saturday,
      DateTime.sunday
    ];

    // This was here to make sure I have 7 days and the data show but for some reason I only get 4 or 5 at a time
    List<WeatherData?> forecastList = [];
    for (int day in daysOfWeek) {
      forecastList.add(dailyForecasts[day]);
    }

    return SingleChildScrollView(
      child: SizedBox(
        height: 180,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: forecastList.length,
          itemBuilder: (context, index) {
            final weatherData = forecastList[index];

            if (weatherData == null) {
              return Container(
                width: 100, // Placeholder width for missing data
                child: Center(child: Text('No data')),
              );
            }

            final formattedDate = DateFormat('E').format(
              DateTime.fromMillisecondsSinceEpoch(weatherData.dt * 1000),
            );

            // To see which temperature to show based on the tapping of the button
            double displayedTemp = isFahrenheit
                ? toFahrenheit(weatherData.temp)
                : weatherData.temp;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  formattedDate,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Image.network(
                  weatherData.iconUrl,
                  height: 80,
                ), // Weather icon
                Text(
                    '${displayedTemp.toStringAsFixed(0)} ${isFahrenheit ? '°F' : '°C'}'), // Temperature
              ],
            );
          },
        ),
      ),
    );
  }
}
