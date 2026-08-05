import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/widgets/app_empty_state_widget.dart';

void main() {
  testWidgets('AppEmptyStateWidget renders title, message, and handles retry callback',
      (WidgetTester tester) async {
    bool retryPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppEmptyStateWidget(
            title: 'No City Provided',
            message: 'Please type a valid city name',
            retryButtonText: 'Retry Search',
            onRetry: () {
              retryPressed = true;
            },
          ),
        ),
      ),
    );

    expect(find.text('No City Provided'), findsOneWidget);
    expect(find.text('Please type a valid city name'), findsOneWidget);
    expect(find.text('Retry Search'), findsOneWidget);

    await tester.tap(find.text('Retry Search'));
    await tester.pump();

    expect(retryPressed, isTrue);
  });
}
