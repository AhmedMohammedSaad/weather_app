import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/theme/app_colors.dart';

/// Shimmer Skeleton loading widget styled for dark purple gradient theme.
class WeatherShimmerWidget extends StatelessWidget {
  const WeatherShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Container(
            width: 140.w,
            height: 32.h,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            width: 80.r,
            height: 80.r,
            decoration: const BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            width: 120.w,
            height: 48.h,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            width: 100.w,
            height: 28.h,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
          SizedBox(height: 32.h),
          Container(
            width: double.infinity,
            height: 140.h,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(24.r),
            ),
          ),
        ],
      ),
    );
  }
}
