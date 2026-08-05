import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/api_constants.dart';
import '../../../../core/errors/error_handler.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/local_data/caching_helper.dart';
import '../models/weather_model.dart';

/// Abstract contract for fetching remote weather data.
abstract class WeatherRemoteDataSource {
  /// Fetches weather details for the provided [cityName].
  Future<WeatherModel> getCurrentWeather(String cityName, {String langCode = 'en'});
}

/// Implementation of [WeatherRemoteDataSource] with Smart City-Based Offline Caching support.
class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final ApiConsumer apiConsumer;

  const WeatherRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<WeatherModel> getCurrentWeather(String cityName, {String langCode = 'en'}) async {
    final trimmedCity = cityName.trim();

    // 1. Validate city input format
    final RegExp validCityRegex = RegExp(r"^[a-zA-Z\s\-]+$");
    if (trimmedCity.isEmpty || !validCityRegex.hasMatch(trimmedCity)) {
      throw ErrorHandler(
        const InvalidCityFailure(
          message: AppStrings.invalidCityName,
        ),
      );
    }

    try {
      // 2. Attempt online API call to WeatherAPI
      final response = await apiConsumer.get(
        ApiConstants.currentWeatherEndpoint,
        queryParameters: {
          'key': ApiConstants.apiKey,
          'q': trimmedCity,
          'lang': langCode,
        },
      );

      final Map<String, dynamic> jsonMap = response is String
          ? jsonDecode(response)
          : Map<String, dynamic>.from(response);

      // 3. Cache fetched weather data locally for this specific city
      AppCacheHelper.cacheLastWeather(trimmedCity, jsonMap);

      return WeatherModel.fromJson(jsonMap);
    } catch (error) {
      // 4. Offline Fallback Strategy:
      // Check if we have cached weather specifically for this requested city (e.g. Cairo or Giza)
      final cachedCityJsonString = AppCacheHelper.getCachedWeatherForCity(trimmedCity);
      
      if (cachedCityJsonString.isNotEmpty) {
        try {
          final cachedJson = jsonDecode(cachedCityJsonString) as Map<String, dynamic>;
          // Return cached city weather without throwing network error
          return WeatherModel.fromJson(cachedJson);
        } catch (_) {
          // If cache parse fails, proceed to error handling below
        }
      }

      // If this requested city was never cached before, rethrow the network/API error
      if (error is ErrorHandler) {
        rethrow;
      }
      throw ErrorHandler.handle(error);
    }
  }
}
