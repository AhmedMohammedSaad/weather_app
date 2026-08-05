import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_style.dart';

/// Small widget displaying the city name with text overflow protection.
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
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
