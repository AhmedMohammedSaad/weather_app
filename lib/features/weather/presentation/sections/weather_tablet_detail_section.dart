import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/app_card.dart';
import '../../domain/entities/weather_entity.dart';
import '../widgets/weather_city_name_widget.dart';
import '../widgets/weather_condition_badge_widget.dart';
import '../widgets/weather_icon_widget.dart';
import '../widgets/weather_metrics_card_widget.dart';
import '../widgets/weather_temperature_widget.dart';

/// Professional Tablet Adaptive Layout per user specification:
/// - Left Column: City Name, Weather Icon, Temperature
/// - Right Column: Weather Metrics Card (Wind Speed & Humidity) + Condition Badge underneath
class WeatherTabletDetailSection extends StatelessWidget {
  final WeatherEntity weather;

  const WeatherTabletDetailSection({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left Pane: City Name, Weather Icon & Temperature
          Expanded(
            flex: 5,
            child: AppCard(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WeatherCityNameWidget(cityName: weather.cityName),
                  SizedBox(height: 12.h),
                  WeatherIconWidget(
                    iconUrl: weather.icon,
                    condition: weather.condition,
                    isDay: weather.isDay,
                  ),
                  SizedBox(height: 12.h),
                  WeatherTemperatureWidget(temperature: weather.temperature),
                ],
              ),
            ),
          ),
          SizedBox(width: 16.w),

          // Right Pane: Weather Metrics Card + Condition Badge underneath
          Expanded(
            flex: 6,
            child: AppCard(
              padding: EdgeInsets.all(16.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WeatherMetricsCardWidget(
                    windSpeed: weather.windSpeed,
                    humidity: weather.humidity,
                  ),
                  SizedBox(height: 16.h),
                  WeatherConditionBadgeWidget(condition: weather.condition),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
