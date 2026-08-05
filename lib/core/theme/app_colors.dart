import 'package:flutter/material.dart';

/// AppColors class defining color tokens including deep purple gradient theme from reference app.
abstract class AppColors {
  // Signature Purple Palette from Reference App
  static const Color primaryPurple = Color(0xFF301957);
  static const Color secondaryPurple = Color(0xFF1E1035);
  static const Color accentPurple = Color(0xFF532E88);

  // Background Gradients
  static const List<Color> backgroundGradient = [
    Color(0xFF301957),
    Color(0xFF1E1035),
  ];

  // Glassmorphic Translucent Card Backgrounds
  static const Color glassCardBackground = Color(0x2BFFFFFF);
  static const Color searchFieldBackground = Color(0xFF301957);

  // Base Colors
  static const Color primary = Color(0xFF301957);
  static const Color primaryDark = Color(0xFF1E1035);
  static const Color accent = Color(0xFF00BCD4);
  static const Color background = Color(0xFF301957);
  static const Color cardBackground = Color(0x33FFFFFF);

  // Text Colors
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xB3FFFFFF);
  static const Color textDark = Color(0xFF1A1D1E);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;

  // Status Colors
  static const Color error = Color(0xFFE53935);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFB300);
  static const Color shimmerBase = Color(0x33FFFFFF);
  static const Color shimmerHighlight = Color(0x66FFFFFF);
}
