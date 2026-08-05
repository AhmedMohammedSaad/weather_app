import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/weather_entity.dart';
import 'weather_city_name_widget.dart';
import 'weather_condition_badge_widget.dart';
import 'weather_icon_widget.dart';
import 'weather_metrics_card_widget.dart';
import 'weather_temperature_widget.dart';

/// Glassmorphic Weather Info Card composing small modular widgets.
class WeatherInfoCardWidget extends StatelessWidget {
  final WeatherEntity weather;

  const WeatherInfoCardWidget({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.h),
        WeatherCityNameWidget(cityName: weather.cityName),
        SizedBox(height: 12.h),
        WeatherIconWidget(
          iconUrl: weather.icon,
          condition: weather.condition,
          isDay: weather.isDay,
        ),
        SizedBox(height: 12.h),
        WeatherTemperatureWidget(temperature: weather.temperature),
        SizedBox(height: 12.h),
        WeatherConditionBadgeWidget(condition: weather.condition),
        SizedBox(height: 28.h),
        WeatherMetricsCardWidget(
          windSpeed: weather.windSpeed,
          humidity: weather.humidity,
        ),
      ],
    );
  }
}
