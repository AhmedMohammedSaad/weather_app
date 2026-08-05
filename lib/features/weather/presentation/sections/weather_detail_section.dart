import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/widgets/app_empty_state_widget.dart';
import '../../../../core/widgets/app_toast.dart';
import '../cubit/weather_cubit.dart';
import '../cubit/weather_state.dart';
import '../widgets/weather_info_card_widget.dart';
import '../widgets/weather_shimmer_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/app_strings.dart';

/// Section component connecting [WeatherCubit] state to UI representation.
/// Consumes Single [WeatherState] with [WeatherStatus] enum.
class WeatherDetailSection extends StatelessWidget {
  const WeatherDetailSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        switch (state.status) {
          case WeatherStatus.loading:
            return const WeatherShimmerWidget();

          case WeatherStatus.success:
            if (state.weather != null) {
              return WeatherInfoCardWidget(weather: state.weather!);
            }
            return const SizedBox.shrink();

          case WeatherStatus.error:
            return AppEmptyStateWidget(
              title: AppStrings.unableToLoadWeather.tr(context: context),
              message:
                  state.errorMessage ??
                  AppStrings.errorFetchingWeather.tr(context: context),
              imagePath: AppImages.rain,
              retryButtonText: AppStrings.tryDefaultCity.tr(context: context),
              onRetry: () {
                context.read<WeatherCubit>().getWeather('Cairo');
              },
            );

          case WeatherStatus.empty:
            return AppEmptyStateWidget(
              title: AppStrings.noCityProvided.tr(context: context),
              message:
                  AppStrings.typeValidCityName.tr(context: context),
              imagePath: AppImages.cloudyNight,
            );

          case WeatherStatus.initial:
          default:
            return AppEmptyStateWidget(
              title: AppStrings.welcomeToWeatherApp.tr(context: context),
              message:
                  AppStrings.typeCityNameToView.tr(context: context),
              imagePath: AppImages.sun,
            );
        }
      },
    );
  }
}
