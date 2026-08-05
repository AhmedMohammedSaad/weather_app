import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_info_card_widget.dart';

void main() {
  const testWeather = WeatherEntity(
    cityName: 'Cairo',
    temperature: 32.5,
    condition: 'Sunny',
    icon: '☀️',
    humidity: 45,
    windSpeed: 12.4,
  );

  Widget createWidgetUnderTest() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return const MaterialApp(
          home: Scaffold(
            body: WeatherInfoCardWidget(weather: testWeather),
          ),
        );
      },
    );
  }

  testWidgets('WeatherInfoCardWidget renders city, temperature, condition, and icon correctly', (WidgetTester tester) async {
    // 1. Build the widget tree
    await tester.pumpWidget(createWidgetUnderTest());

    // 2. Verify all core required weather items are present
    expect(find.text('Cairo'), findsOneWidget);
    expect(find.text('32.5°C'), findsOneWidget);
    expect(find.text('Sunny'), findsOneWidget);
    expect(find.text('☀️'), findsOneWidget);

    // 3. Verify additional metrics
    expect(find.text('45%'), findsOneWidget);
    expect(find.text('12.4 km/h'), findsOneWidget);
  });
}
