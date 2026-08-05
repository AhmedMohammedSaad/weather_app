import '../../domain/entities/weather_entity.dart';

/// Enum representing the status of weather state.
enum WeatherStatus { initial, loading, success, error, empty }

/// Single State class for Weather feature supporting real-time online status.
class WeatherState {
  final WeatherStatus status;
  final WeatherEntity? weather;
  final String? errorMessage;
  final bool isOnline;

  const WeatherState({
    this.status = WeatherStatus.initial,
    this.weather,
    this.errorMessage,
    this.isOnline = true,
  });

  /// Factory constructor for initial state.
  factory WeatherState.initial() => const WeatherState(status: WeatherStatus.initial, isOnline: true);

  /// Creates a copy of [WeatherState] with modified fields.
  WeatherState copyWith({
    WeatherStatus? status,
    WeatherEntity? weather,
    String? errorMessage,
    bool? isOnline,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
      errorMessage: errorMessage ?? this.errorMessage,
      isOnline: isOnline ?? this.isOnline,
    );
  }
}
