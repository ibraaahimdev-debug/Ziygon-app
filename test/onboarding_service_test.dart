import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ziygon/core/services/onboarding_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('OnboardingService Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('initial state hasSeenOnboarding should be false', () async {
      final hasSeen = await OnboardingService.hasSeenOnboarding();
      expect(hasSeen, isFalse);
    });

    test('completeOnboarding sets hasSeenOnboarding to true', () async {
      await OnboardingService.completeOnboarding();
      final hasSeen = await OnboardingService.hasSeenOnboarding();
      expect(hasSeen, isTrue);
    });

    test('resetOnboarding removes flag and returns false', () async {
      await OnboardingService.completeOnboarding();
      expect(await OnboardingService.hasSeenOnboarding(), isTrue);

      await OnboardingService.resetOnboarding();
      expect(await OnboardingService.hasSeenOnboarding(), isFalse);
    });
  });
}
