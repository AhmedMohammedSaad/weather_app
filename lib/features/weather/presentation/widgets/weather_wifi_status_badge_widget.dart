import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/weather_cubit.dart';
import '../cubit/weather_state.dart';

/// Wifi connectivity status badge widget.
class WeatherWifiStatusBadgeWidget extends StatelessWidget {
  const WeatherWifiStatusBadgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        final bool isOnline = state.isOnline;
        final color = isOnline ? AppColors.success : AppColors.error;

        return Icon(
          isOnline ? Icons.wifi : Icons.wifi_off,
          size: 20.r,
          color: color,
        );
      },
    );
  }
}
