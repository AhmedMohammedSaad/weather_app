import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Helper utility for detecting screen breakpoints and adapting layout & font sizes for Mobile & Tablet devices.
abstract class AppResponsiveHelper {
  AppResponsiveHelper._();

  /// Threshold width in pixels for tablet devices
  static const double tabletBreakpoint = 600.0;

  /// Returns true if the device screen width is considered a tablet
  static bool isTablet(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= tabletBreakpoint;
  }

  /// Returns true if the device is in landscape orientation
  static bool isLandscape(BuildContext context) {
    return MediaQuery.orientationOf(context) == Orientation.landscape;
  }

  /// Returns a normalized font size that stays elegant and proportional on Tablet screens,
  /// preventing excessive .sp auto-scaling distortion on large screens.
  static double getFontSize(BuildContext context, double mobileSize) {
    if (isTablet(context)) {
      return mobileSize * 1.1; // Controlled 10% scale for tablet, avoiding huge font explosion
    }
    return mobileSize.sp;
  }
}
