import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ziygon/features/home/presentation/home_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('HomeScreen renders header, sections, and navigation bar', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreen(),
      ),
    );

    // Verify Header text
    expect(find.text('Hey,'), findsOneWidget);
    expect(find.text("How's your day going"), findsOneWidget);

    // Verify Section Headers
    expect(find.text('Quick Start'), findsOneWidget);
    expect(find.text('Territory'), findsOneWidget);
    expect(find.text('Active Challenges'), findsOneWidget);
    expect(find.text('Nearby Routes'), findsOneWidget);

    // Verify Quick Start Activity Titles
    expect(find.text('Running'), findsOneWidget);
    expect(find.text('Cycling'), findsOneWidget);
    expect(find.text('Walking'), findsOneWidget);
  });
}
