import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

/// Small widget displaying the temperature formatted value.
class WeatherTemperatureWidget extends StatelessWidget {
  final double temperature;

  const WeatherTemperatureWidget({
    super.key,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '${temperature.toStringAsFixed(1)}°C',
      style: AppTextStyle.heading1.copyWith(
        fontSize: 48.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.white,
      ),
    );
  }
}
