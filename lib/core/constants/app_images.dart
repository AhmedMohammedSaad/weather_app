/// Centralized image assets manager to avoid hardcoded asset strings across the app.
abstract class AppImages {
  AppImages._();

  static const String basePath = 'assets/images/png';

  static const String sun = '$basePath/sun.png';
  static const String cloudy = '$basePath/cloudy.png';
  static const String rain = '$basePath/rain.png';
  static const String cloudyNight = '$basePath/cloudy-night.png';
}
