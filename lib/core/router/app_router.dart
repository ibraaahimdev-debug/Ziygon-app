import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/auth_screen.dart';
import '../../features/auth/presentation/sign_up_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/profile_setup/presentation/all_done_screen.dart';
import '../../features/profile_setup/presentation/gender_selection_screen.dart';
import '../../features/profile_setup/presentation/height_selection_screen.dart';
import '../../features/profile_setup/presentation/weight_selection_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../../features/territory/presentation/map_tab_screen.dart';
import '../../features/territory/presentation/territory_cell_detail_screen.dart';
import '../../features/territory/presentation/territory_dark_mode_screen.dart';
import '../../features/territory/presentation/territory_tracking_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/gender',
        name: 'gender',
        builder: (context, state) => const GenderSelectionScreen(),
      ),
      GoRoute(
        path: '/weight',
        name: 'weight',
        builder: (context, state) => const WeightSelectionScreen(),
      ),
      GoRoute(
        path: '/height',
        name: 'height',
        builder: (context, state) => const HeightSelectionScreen(),
      ),
      GoRoute(
        path: '/all-done',
        name: 'allDone',
        builder: (context, state) => const AllDoneScreen(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/auth',
        name: 'auth',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/map',
        name: 'map',
        builder: (context, state) => const MapTabScreen(),
      ),
      GoRoute(
        path: '/territory-tracking',
        name: 'territoryTracking',
        builder: (context, state) => const TerritoryTrackingScreen(),
      ),
      GoRoute(
        path: '/territory-dark-mode',
        name: 'territoryDarkMode',
        builder: (context, state) => const TerritoryDarkModeScreen(),
      ),
      GoRoute(
        path: '/territory-cell-detail',
        name: 'territoryCellDetail',
        builder: (context, state) => const TerritoryCellDetailScreen(),
      ),
    ],
  );
}
