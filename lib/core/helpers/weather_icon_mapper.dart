import '../constants/app_images.dart';

/// Utility helper responsible for mapping weather condition text, icon URLs,
/// and isDay state to local high-quality PNG asset paths defined in [AppImages].
abstract class WeatherIconMapper {
  WeatherIconMapper._();

  /// Maps condition text, raw API icon URL, and isDay state to a local PNG asset path.
  static String getAssetForCondition({
    required String text,
    required String rawUrl,
    bool isDay = true,
  }) {
    final lowerText = text.toLowerCase();
    final lowerUrl = rawUrl.toLowerCase();

    // Detect night time from isDay boolean OR URL/text containing night
    final isNight = !isDay ||
        lowerUrl.contains('night') ||
        lowerText.contains('night') ||
        lowerText.contains('ليل') ||
        lowerText.contains('ليلي');

    // 1. Rain / Drizzle / Shower / Thunderstorm -> Rain Asset
    if (lowerText.contains('rain') ||
        lowerText.contains('drizzle') ||
        lowerText.contains('shower') ||
        lowerText.contains('thunder') ||
        lowerText.contains('مطر') ||
        lowerText.contains('ممطر') ||
        lowerText.contains('رعد')) {
      return AppImages.rain;
    }

    // 2. Cloudy / Overcast / Mist / Fog -> Cloudy / CloudyNight Asset
    if (lowerText.contains('cloud') ||
        lowerText.contains('overcast') ||
        lowerText.contains('mist') ||
        lowerText.contains('fog') ||
        lowerText.contains('غائم') ||
        lowerText.contains('سحب') ||
        lowerText.contains('غيوم') ||
        lowerText.contains('ضباب')) {
      if (isNight) {
        return AppImages.cloudyNight;
      }
      return AppImages.cloudy;
    }

    // 3. Clear / Sunny conditions
    if (isNight) {
      return AppImages.cloudyNight;
    }

    // Daytime Clear / Sunny -> Sun Asset
    return AppImages.sun;
  }
}
