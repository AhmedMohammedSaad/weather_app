import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../cubit/weather_cubit.dart';
import '../cubit/weather_state.dart';

/// Pill-shaped search bar widget for city weather lookup.
class WeatherSearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearchSubmitted;

  const WeatherSearchBarWidget({
    super.key,
    required this.controller,
    required this.onSearchSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.searchFieldBackground,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: AppColors.white.withOpacity(0.2), width: 1.w),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: AppColors.textSecondary),
          SizedBox(width: 8.w),
          Expanded(
            child: TextField(
              controller: controller,
              style: AppTextStyle.bodyLarge,
              decoration: InputDecoration(
                hintText: AppStrings.searchCityHint.tr(context: context),
                hintStyle: AppTextStyle.bodyMedium,
                border: InputBorder.none,
              ),
              onSubmitted: (_) => onSearchSubmitted(),
            ),
          ),
          BlocBuilder<WeatherCubit, WeatherState>(
            builder: (context, state) {
              if (state.status == WeatherStatus.loading) {
                return SizedBox(
                  width: 20.r,
                  height: 20.r,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                  ),
                );
              }
              return InkWell(
                onTap: onSearchSubmitted,
                borderRadius: BorderRadius.circular(20.r),
                child: Padding(
                  padding: EdgeInsets.all(6.r),
                  child: const Icon(
                    Icons.search,
                    color: AppColors.white,
                    size: 24,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
