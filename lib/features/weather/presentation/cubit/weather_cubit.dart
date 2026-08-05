import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/networking/network_info.dart';
import '../../domain/usecases/get_current_weather_usecase.dart';
import 'weather_state.dart';

/// Cubit managing weather business logic and real-time connectivity auto-sync.
class WeatherCubit extends Cubit<WeatherState> {
  final GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  final NetworkInfo networkInfo;

  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  String _currentCity = 'Cairo';
  String _currentLang = 'en';

  WeatherCubit(this.getCurrentWeatherUseCase, this.networkInfo)
      : super(WeatherState.initial()) {
    _initConnectivityListener();
  }

  /// Initializes real-time connectivity monitoring and handles auto-reconnect sync.
  void _initConnectivityListener() async {
    final initialConnected = await networkInfo.isConnected;
    emit(state.copyWith(isOnline: initialConnected));

    _connectivitySubscription = networkInfo.onConnectivityChanged.listen((results) {
      final isOnlineNow = results.any((r) =>
          r == ConnectivityResult.mobile ||
          r == ConnectivityResult.wifi ||
          r == ConnectivityResult.ethernet);

      final wasOffline = !state.isOnline;
      emit(state.copyWith(isOnline: isOnlineNow));

      // Auto-sync without manual refresh when internet connection is restored!
      if (wasOffline && isOnlineNow) {
        getWeather(_currentCity);
      }
    });
  }

  /// Fetches weather data for [cityName].
  Future<void> getWeather(String cityName, {String? langCode}) async {
    final trimmedCity = cityName.trim();

    if (langCode != null) {
      _currentLang = langCode;
    }

    if (trimmedCity.isEmpty) {
      emit(state.copyWith(
        status: WeatherStatus.empty,
        errorMessage: 'City name cannot be empty.',
      ));
      return;
    }

    _currentCity = trimmedCity;

    // Check connectivity status before fetching
    final isConnected = await networkInfo.isConnected;
    emit(state.copyWith(isOnline: isConnected));

    // 1. Emit loading status
    emit(state.copyWith(status: WeatherStatus.loading));

    // 2. Call UseCase
    final result = await getCurrentWeatherUseCase(trimmedCity, langCode: _currentLang);

    // 3. Update state with Success or Error status
    result.fold(
      (weather) => emit(state.copyWith(
        status: WeatherStatus.success,
        weather: weather,
      )),
      (failure) => emit(state.copyWith(
        status: WeatherStatus.error,
        errorMessage: failure.message,
      )),
    );
  }

  /// Changes the application language state and fetches the weather again to get localized API response.
  Future<void> changeLanguageAndRefresh(String langCode) async {
    _currentLang = langCode;
    if (_currentCity.isNotEmpty) {
      await getWeather(_currentCity);
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
