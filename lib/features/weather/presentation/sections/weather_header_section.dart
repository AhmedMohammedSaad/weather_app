import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_strings.dart';
import 'package:easy_localization/easy_localization.dart';
import '../cubit/weather_cubit.dart';
import '../widgets/weather_search_bar_widget.dart';
import '../widgets/weather_wifi_status_badge_widget.dart';

/// Section component providing title, wifi status indicator, and search bar.
class WeatherHeaderSection extends StatefulWidget {
  const WeatherHeaderSection({super.key});

  @override
  State<WeatherHeaderSection> createState() => _WeatherHeaderSectionState();
}

class _WeatherHeaderSectionState extends State<WeatherHeaderSection> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchSubmitted() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      context.read<WeatherCubit>().getWeather(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppStrings.appName.tr(),
              style: AppTextStyle.heading1.copyWith(
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8.w),
            const WeatherWifiStatusBadgeWidget(),
            const Spacer(),
            TextButton(
              onPressed: () {
                final newLang = context.locale.languageCode == 'ar'
                    ? 'en'
                    : 'ar';
                context.setLocale(Locale(newLang));
                context.read<WeatherCubit>().changeLanguageAndRefresh(newLang);
              },
              child: Text(
                context.locale.languageCode == 'ar' ? 'English' : 'عربي',
                style: AppTextStyle.heading1.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        WeatherSearchBarWidget(
          controller: _searchController,
          onSearchSubmitted: _onSearchSubmitted,
        ),
      ],
    );
  }
}
