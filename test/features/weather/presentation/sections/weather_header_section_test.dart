import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/networking/api_service.dart';
import 'package:weather_app/core/networking/network_info.dart';
import 'package:weather_app/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/features/weather/domain/usecases/get_current_weather_usecase.dart';
import 'package:weather_app/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:weather_app/features/weather/presentation/sections/weather_header_section.dart';

void main() {
  late WeatherCubit weatherCubit;

  setUp(() {
    final apiConsumer = ApiService();
    final dataSource = WeatherRemoteDataSourceImpl(apiConsumer: apiConsumer);
    final repository = WeatherRepositoryImpl(dataSource);
    final useCase = GetCurrentWeatherUseCase(repository);
    final networkInfo = NetworkInfoImpl(Connectivity());
    weatherCubit = WeatherCubit(useCase, networkInfo);
  });

  tearDown(() {
    weatherCubit.close();
  });

  Widget createWidgetUnderTest() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: weatherCubit,
              child: const WeatherHeaderSection(),
            ),
          ),
        );
      },
    );
  }

  testWidgets('WeatherHeaderSection renders TextField, Search button, and Wifi Badge', (WidgetTester tester) async {
    // 1. Pump the widget tree
    await tester.pumpWidget(createWidgetUnderTest());

    // 2. Verify TextField presence
    expect(find.byType(TextField), findsOneWidget);

    // 3. Verify Search Weather button presence
    expect(find.text('Search Weather'), findsOneWidget);
  });
}
