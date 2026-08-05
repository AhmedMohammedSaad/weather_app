import '../../../../core/api/api_result.dart';
import '../entities/weather_entity.dart';

abstract class WeatherRepository {
  Future<ApiResult<WeatherEntity>> getCurrentWeather(String cityName, {String langCode = 'en'});
}
