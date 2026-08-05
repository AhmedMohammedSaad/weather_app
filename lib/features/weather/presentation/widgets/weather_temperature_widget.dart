import 'package:flutter/material.dart';
import '../../../../core/helpers/app_responsive_helper.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

/// Small widget displaying the temperature formatted value with tablet normalization.
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
        fontSize: AppResponsiveHelper.getFontSize(context, 44),
        fontWeight: FontWeight.w800,
        color: AppColors.white,
      ),
    );
  }
}
