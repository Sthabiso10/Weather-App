class Weather {
  final WeatherParams weatherParams;
  final List<WeatherInfo> weatherInfo;
  final int dt;

  Weather({
    required this.weatherParams,
    required this.weatherInfo,
    required this.dt,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      weatherParams: WeatherParams.fromJson(json['main']),
      weatherInfo: (json['weather'] as List)
          .map((item) => WeatherInfo.fromJson(item))
          .toList(),
      dt: json['dt'],
    );
  }
}

class WeatherParams {
  final double temp;
  final double tempMin;
  final double tempMax;

  WeatherParams({
    required this.temp,
    required this.tempMin,
    required this.tempMax,
  });

  factory WeatherParams.fromJson(Map<String, dynamic> json) {
    return WeatherParams(
      temp: json['temp'],
      tempMin: json['temp_min'],
      tempMax: json['temp_max'],
    );
  }
}

class WeatherInfo {
  final String main;
  final String description;
  final String icon;

  WeatherInfo({
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}
