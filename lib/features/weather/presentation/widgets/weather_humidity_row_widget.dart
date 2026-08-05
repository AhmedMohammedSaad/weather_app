import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

/// Row widget displaying humidity percentage metric.
class WeatherHumidityRowWidget extends StatelessWidget {
  final int humidity;

  const WeatherHumidityRowWidget({
    super.key,
    required this.humidity,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.water_drop_outlined, color: AppColors.white, size: 20),
            SizedBox(width: 8.w),
            Text(
              AppStrings.humidity.tr(context: context),
              style: AppTextStyle.bodyMedium.copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
        Text(
          '$humidity%',
          style: AppTextStyle.heading3.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
