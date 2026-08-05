import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import '../../api/api_consumer.dart';
import '../../networking/api_service.dart';
import '../../networking/network_info.dart';
import '../../../features/weather/data/datasources/weather_remote_data_source.dart';
import '../../../features/weather/data/repositories/weather_repository_impl.dart';
import '../../../features/weather/domain/repositories/weather_repository.dart';
import '../../../features/weather/domain/usecases/get_current_weather_usecase.dart';
import '../../../features/weather/presentation/cubit/weather_cubit.dart';

final sl = GetIt.instance;

class ServiceLocator {
  static void init() {
    /// External Dependencies
    sl.registerLazySingleton<Connectivity>(() => Connectivity());
    sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl<Connectivity>()));

    /// Core / Networking Services
    sl.registerLazySingleton<ApiConsumer>(() => ApiService());

    /// Data Sources
    sl.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(apiConsumer: sl<ApiConsumer>()),
    );

    /// Repositories
    sl.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(sl<WeatherRemoteDataSource>()),
    );

    /// Use Cases
    sl.registerLazySingleton<GetCurrentWeatherUseCase>(
      () => GetCurrentWeatherUseCase(sl<WeatherRepository>()),
    );

    /// Cubits / Blocs (Factory for per-screen creation)
    sl.registerFactory<WeatherCubit>(
      () => WeatherCubit(
        sl<GetCurrentWeatherUseCase>(),
        sl<NetworkInfo>(),
      ),
    );
  }
}
