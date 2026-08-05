import '../../../../core/api/api_result.dart';
import '../entities/weather_entity.dart';
import '../repositories/weather_repository.dart';

class GetCurrentWeatherUseCase {
  final WeatherRepository repository;

  const GetCurrentWeatherUseCase(this.repository);

  Future<ApiResult<WeatherEntity>> call(String cityName, {String langCode = 'en'}) async {
    return await repository.getCurrentWeather(cityName, langCode: langCode);
  }
}
