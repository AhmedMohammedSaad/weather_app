import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/router/app_router.dart';
import 'package:weather_app/main.dart';

void main() {
  testWidgets('WeatherApp renders successfully and displays main header', (WidgetTester tester) async {
    // Build WeatherApp and trigger a frame.
    await tester.pumpWidget(WeatherApp(appRouter: AppRouter()));

    // Allow initial async delayed state to complete
    await tester.pump(const Duration(seconds: 1));

    // Verify that Weather Forecast header is rendered
    expect(find.text('Weather Forecast'), findsOneWidget);
    expect(find.text('Search Weather'), findsOneWidget);
  });
}
