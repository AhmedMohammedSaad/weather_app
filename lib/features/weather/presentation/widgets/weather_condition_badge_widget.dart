import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

/// Glassmorphic pill badge displaying condition text.
class WeatherConditionBadgeWidget extends StatelessWidget {
  final String condition;

  const WeatherConditionBadgeWidget({
    super.key,
    required this.condition,
  });

  @override
  Widget build(BuildContext context) {
    final String displayCondition = condition.isNotEmpty ? condition : 'Clear';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.glassCardBackground,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColors.white.withOpacity(0.2),
          width: 1.w,
        ),
      ),
      child: Text(
        '🌿 $displayCondition',
        style: AppTextStyle.heading3.copyWith(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
      ),
    );
  }
}
