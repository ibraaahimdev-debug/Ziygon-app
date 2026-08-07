import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ziygon/features/onboarding/presentation/onboarding_screen.dart';
import 'package:ziygon/features/onboarding/presentation/widgets/page_indicator.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('OnboardingScreen displays Card 1 headline and skip button',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: OnboardingScreen(),
      ),
    );

    // Verify Skip button exists
    expect(find.text('Skip'), findsOneWidget);

    // Verify Card 1 headline exists
    expect(find.text('Track Every Move'), findsOneWidget);

    // Verify PageIndicator widget is present
    expect(find.byType(PageIndicator), findsOneWidget);
  });
}
