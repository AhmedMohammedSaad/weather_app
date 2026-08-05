import 'package:flutter/material.dart';
import '../../../../core/helpers/app_responsive_helper.dart';
import '../../../../core/theme/app_text_style.dart';

/// Small widget displaying the city name with text overflow protection & tablet font normalization.
class WeatherCityNameWidget extends StatelessWidget {
  final String cityName;

  const WeatherCityNameWidget({
    super.key,
    required this.cityName,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      cityName,
      style: AppTextStyle.heading1.copyWith(
        fontSize: AppResponsiveHelper.getFontSize(context, 26),
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
