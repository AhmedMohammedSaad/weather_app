import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_info_card_widget.dart';

void main() {
  testWidgets('WeatherInfoCardWidget renders full weather details entity correctly',
      (WidgetTester tester) async {
    const testWeather = WeatherEntity(
      cityName: 'Cairo',
      temperature: 28.0,
      condition: 'Clear',
      icon: 'assets/images/png/sun.png',
      humidity: 50,
      windSpeed: 15.0,
      isDay: true,
    );

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: WeatherInfoCardWidget(weather: testWeather),
            ),
          ),
        ),
      ),
    );

    expect(find.text('Cairo'), findsOneWidget);
    expect(find.text('28°'), findsOneWidget);
    expect(find.text('🌿 Clear'), findsOneWidget);
    expect(find.text('15.0 km/h'), findsOneWidget);
    expect(find.text('50%'), findsOneWidget);
  });
}
