class WeatherEntity {
  final String cityName;
  final double temperature;
  final String condition;
  final String icon;
  final int humidity;
  final double windSpeed;
  final bool isDay;

  const WeatherEntity({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
    this.isDay = true,
  });
}
