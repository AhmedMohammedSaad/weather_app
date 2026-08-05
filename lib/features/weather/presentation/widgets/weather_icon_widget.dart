import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/weather_icon_mapper.dart';

/// Pure UI Weather Icon Widget displaying high-quality local PNG assets.
class WeatherIconWidget extends StatelessWidget {
  final String iconUrl;
  final String? condition;
  final bool isDay;

  const WeatherIconWidget({
    super.key,
    required this.iconUrl,
    this.condition,
    this.isDay = true,
  });

  @override
  Widget build(BuildContext context) {
    final String assetPath = WeatherIconMapper.getAssetForCondition(
      text: condition ?? iconUrl,
      rawUrl: iconUrl,
      isDay: isDay,
    );

    return Image.asset(
      assetPath,
      width: 100.r,
      height: 100.r,
      fit: BoxFit.contain,
    );
  }
}
