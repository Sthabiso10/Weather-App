import 'dart:convert';

class WeatherData {
  final String city;
  final double temp;
  final double minTemp;
  final double maxTemp;
  final String iconUrl;
  final int dt; // DateTime

  WeatherData({
    required this.city,
    required this.temp,
    required this.minTemp,
    required this.maxTemp,
    required this.iconUrl,
    required this.dt,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      city: json['name'] ?? '',
      temp: (json['main']['temp'] as num?)?.toDouble() ??
          0.0, // Convert to double or provide default
      minTemp: (json['main']['temp_min'] as num?)?.toDouble() ?? 0.0,
      maxTemp: (json['main']['temp_max'] as num?)?.toDouble() ?? 0.0,
      iconUrl: _getIconUrl(json['weather'][0]['icon'] ?? ''),
      dt: json['dt'] ?? 0,
    );
  }

  static String _getIconUrl(String iconCode) {
    return 'http://openweathermap.org/img/wn/$iconCode.png';
  }
}
