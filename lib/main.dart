import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_weather_example_flutter/src/features/weather/application/providers.dart';
import 'package:open_weather_example_flutter/src/features/weather/presentation/weather_page.dart';
import 'package:provider/provider.dart';

final sl = GetIt.instance;

void setupInjection() {
  sl.registerLazySingleton<String>(() => '70ed201b1aef7ef15327fa7e566cb591',
      instanceName: 'api_key');
}

void main() {
  setupInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyleWithShadow = TextStyle(color: Colors.white, shadows: [
      BoxShadow(
        color: Colors.black12.withOpacity(0.25),
        spreadRadius: 1,
        blurRadius: 4,
        offset: const Offset(0, 0.5),
      )
    ]);
    return MaterialApp(
      title: 'Flutter Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: TextTheme(
          displayLarge: textStyleWithShadow,
          displayMedium: textStyleWithShadow,
          displaySmall: textStyleWithShadow,
          headlineMedium: textStyleWithShadow,
          headlineSmall: textStyleWithShadow,
          titleMedium: const TextStyle(color: Colors.white),
          bodyMedium: const TextStyle(color: Colors.white),
          bodyLarge: const TextStyle(color: Colors.white),
          bodySmall: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
      ),
      home: MultiProvider(
          providers: [
            ChangeNotifierProvider<WeatherProvider>(
                create: (_) =>
                    WeatherProvider(apiKey: '70ed201b1aef7ef15327fa7e566cb591'),
                lazy: false),
          ],
          builder: (context, _) {
            return const WeatherPage(city: 'London');
          }),
    );
  }
}
