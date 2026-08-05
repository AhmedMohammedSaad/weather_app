import 'package:flutter/material.dart';
import '../constants/app_images.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';

class AppEmptyStateWidget extends StatelessWidget {
  final String title;
  final String? message;
  final String imagePath;
  final VoidCallback? onRetry;
  final String? retryButtonText;

  const AppEmptyStateWidget({
    super.key,
    required this.title,
    this.message,
    this.imagePath = AppImages.cloudy,
    this.onRetry,
    this.retryButtonText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 80,
              height: 80,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: AppTextStyle.heading3,
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              const SizedBox(height: 8),
              Text(
                message!,
                style: AppTextStyle.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: onRetry,
                child: Text(
                  retryButtonText ?? 'Retry',
                  style: AppTextStyle.button,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
