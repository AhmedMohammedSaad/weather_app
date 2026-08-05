import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_temperature_widget.dart';

void main() {
  testWidgets('WeatherTemperatureWidget displays temperature rounded value correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => const MaterialApp(
          home: Scaffold(
            body: WeatherTemperatureWidget(temperature: 27.8),
          ),
        ),
      ),
    );

    expect(find.text('28°'), findsOneWidget);
  });
}
