import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_metrics_card_widget.dart';

void main() {
  testWidgets('WeatherMetricsCardWidget displays wind speed and humidity values',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => const MaterialApp(
          home: Scaffold(
            body: WeatherMetricsCardWidget(
              windSpeed: 11.9,
              humidity: 44,
            ),
          ),
        ),
      ),
    );

    expect(find.text('11.9 km/h'), findsOneWidget);
    expect(find.text('44%'), findsOneWidget);
  });
}
