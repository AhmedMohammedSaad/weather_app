import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

/// Row widget displaying wind speed metric in km/h and mph.
class WeatherWindSpeedRowWidget extends StatelessWidget {
  final double windSpeed;

  const WeatherWindSpeedRowWidget({super.key, required this.windSpeed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.air, color: AppColors.white, size: 20),
            SizedBox(width: 8.w),
            Text(
              AppStrings.windSpeed.tr(context: context),
              style: AppTextStyle.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        Text(
          '${windSpeed.toStringAsFixed(1)} km/h',
          style: AppTextStyle.heading3.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
