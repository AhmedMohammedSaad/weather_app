import '../../domain/entities/weather_entity.dart';

/// Data model representing Weather data received from WeatherAPI.
/// Extends [WeatherEntity] to maintain Clean Architecture separation.
class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required super.cityName,
    required super.temperature,
    required super.condition,
    required super.icon,
    required super.humidity,
    required super.windSpeed,
    super.isDay = true,
  });

  /// Factory constructor to deserialize JSON response from WeatherAPI.
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final location = json['location'] as Map<String, dynamic>? ?? {};
    final current = json['current'] as Map<String, dynamic>? ?? {};
    final conditionObj = current['condition'] as Map<String, dynamic>? ?? {};

    // Process icon URL (WeatherAPI returns relative protocol URLs like "//cdn.weatherapi.com/...")
    String rawIcon = conditionObj['icon'] ?? '';
    if (rawIcon.startsWith('//')) {
      rawIcon = 'https:$rawIcon';
    }

    return WeatherModel(
      cityName: location['name'] ?? '',
      temperature: (current['temp_c'] as num?)?.toDouble() ?? 0.0,
      condition: conditionObj['text'] ?? '',
      icon: rawIcon,
      humidity: current['humidity'] ?? 0,
      windSpeed: (current['wind_kph'] as num?)?.toDouble() ?? 0.0,
      isDay: (current['is_day'] as num?) == 1,
    );
  }

  /// Converts [WeatherModel] to JSON format.
  Map<String, dynamic> toJson() {
    return {
      'location': {
        'name': cityName,
      },
      'current': {
        'temp_c': temperature,
        'is_day': isDay ? 1 : 0,
        'condition': {
          'text': condition,
          'icon': icon,
        },
        'humidity': humidity,
        'wind_kph': windSpeed,
      },
    };
  }
}
