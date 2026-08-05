import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../constants/app_strings.dart';
import '../services/service_locator/service_locator.dart';
import '../../features/weather/presentation/cubit/weather_cubit.dart';
import '../../features/weather/presentation/view/weather_view.dart';
import 'routes.dart';

/// AppRouter class handling application navigation and injecting dependencies via [ServiceLocator].
class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.weatherView:
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<WeatherCubit>()..getWeather('Cairo'),
            child: const WeatherView(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(AppStrings.noRouteDefined.tr(args: [settings.name ?? ''])),
            ),
          ),
        );
    }
  }
}
