import '../../../../core/api/api_result.dart';
import '../../../../core/errors/error_handler.dart';
import '../../domain/entities/weather_entity.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_remote_data_source.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  const WeatherRepositoryImpl(this.remoteDataSource);

  @override
  Future<ApiResult<WeatherEntity>> getCurrentWeather(String cityName, {String langCode = 'en'}) async {
    try {
      final weatherModel = await remoteDataSource.getCurrentWeather(cityName, langCode: langCode);
      return SuccessResult(weatherModel);
    } catch (error) {
      final errorHandler = ErrorHandler.handle(error);
      return FailureResult(errorHandler.failure);
    }
  }
}
