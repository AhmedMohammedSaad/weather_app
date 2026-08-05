import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import 'weather_humidity_row_widget.dart';
import 'weather_wind_speed_row_widget.dart';

/// Translucent glass container displaying weather metrics (Wind Speed & Humidity).
class WeatherMetricsCardWidget extends StatelessWidget {
  final double windSpeed;
  final int humidity;

  const WeatherMetricsCardWidget({
    super.key,
    required this.windSpeed,
    required this.humidity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.glassCardBackground,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: AppColors.white.withOpacity(0.15),
          width: 1.w,
        ),
      ),
      child: Column(
        children: [
          WeatherWindSpeedRowWidget(windSpeed: windSpeed),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Divider(color: AppColors.white.withOpacity(0.1)),
          ),
          WeatherHumidityRowWidget(humidity: humidity),
        ],
      ),
    );
  }
}
