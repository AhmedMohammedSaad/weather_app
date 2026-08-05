import 'package:flutter/material.dart';

/// Helper utility for detecting screen breakpoints and adapting layout for Mobile & Tablet devices.
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
}
