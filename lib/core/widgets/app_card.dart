import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color backgroundColor;
  final double borderRadius;
  final double elevation;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16.0),
    this.margin = EdgeInsets.zero,
    this.backgroundColor = AppColors.cardBackground,
    this.borderRadius = 16.0,
    this.elevation = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: elevation > 0
            ? [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.05),
                  blurRadius: elevation * 4,
                  offset: Offset(0, elevation),
                ),
              ]
            : null,
      ),
      child: child,
    );
  }
}
