import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../sections/weather_detail_section.dart';
import '../sections/weather_header_section.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:nb_utils/nb_utils.dart';
import '../cubit/weather_cubit.dart';
import '../cubit/weather_state.dart';

import '../../../../core/helpers/app_responsive_helper.dart';
import '../../../../core/constants/app_strings.dart';

/// Screen View component representing the Weather feature page.
/// Styled with full-screen purple linear gradient matching the reference app design.
class WeatherView extends StatelessWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isTablet = AppResponsiveHelper.isTablet(context);

    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<WeatherCubit, WeatherState>(
            listenWhen: (previous, current) =>
                previous.isOnline != current.isOnline,
            listener: (context, state) {
              if (!state.isOnline) {
                toast(
                  AppStrings.noInternetConnection.tr(context: context),
                  bgColor: AppColors.error,
                  textColor: AppColors.white,
                );
              } else {
                toast(
                  AppStrings.internetReturned.tr(context: context),
                  bgColor: AppColors.success,
                  textColor: AppColors.white,
                );
              }
            },
          ),
          BlocListener<WeatherCubit, WeatherState>(
            listenWhen: (previous, current) =>
                previous.status != current.status &&
                current.status == WeatherStatus.error,
            listener: (context, state) {
              if (state.errorMessage != null) {
                toast(
                  state.errorMessage!,
                  bgColor: AppColors.error,
                  textColor: AppColors.white,
                );
              }
            },
          ),
        ],
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColors.backgroundGradient,
            ),
          ),
          child: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isTablet ? 900.w : double.infinity,
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 36.w : 20.w,
                    vertical: 16.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const WeatherHeaderSection(),
                      SizedBox(height: 24.h),
                      const WeatherDetailSection(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
