import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_city_name_widget.dart';

void main() {
  testWidgets('WeatherCityNameWidget displays provided city name correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => const MaterialApp(
          home: Scaffold(
            body: WeatherCityNameWidget(cityName: 'Cairo'),
          ),
        ),
      ),
    );

    expect(find.text('Cairo'), findsOneWidget);
  });
}
