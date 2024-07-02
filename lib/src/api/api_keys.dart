import 'package:get_it/get_it.dart';

/// To get an API key, sign up here:
/// https://home.openweathermap.org/users/sign_up
///

final sl = GetIt.instance;

void setupInjection() {
  //TODO setup injection using 'api_key' instance name. Refer to https://pub.dev/packages/get_it for documentation
  sl.registerLazySingleton<String>(() => '70ed201b1aef7ef15327fa7e566cb591',
      instanceName: 'api_key');
}
