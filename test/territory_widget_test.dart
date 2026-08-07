import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ziygon/features/territory/presentation/map_tab_screen.dart';
import 'package:ziygon/features/territory/presentation/territory_cell_detail_screen.dart';
import 'package:ziygon/features/territory/presentation/territory_dark_mode_screen.dart';
import 'package:ziygon/features/territory/presentation/territory_tracking_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('MapTabScreen (Screen 1) renders jogging & territory cards', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MapTabScreen(),
      ),
    );

    expect(find.text('Start\njogging'), findsOneWidget);
    expect(find.text('Enter in\nTerritory\nMod'), findsOneWidget);
  });

  testWidgets('TerritoryTrackingScreen (Screen 2) renders stats and action buttons', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: TerritoryTrackingScreen(),
      ),
    );

    expect(find.text('13:01:00'), findsOneWidget);
    expect(find.text('340 kcal'), findsOneWidget);
    expect(find.text('6,500'), findsOneWidget);
    expect(find.text('12.4 km/h'), findsOneWidget);
    expect(find.text('Rival Zone'), findsOneWidget);
  });

  testWidgets('TerritoryDarkModeScreen (Screen 3) renders dark rival zone & stats', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: TerritoryDarkModeScreen(),
      ),
    );

    expect(find.text('RIVAL ZONE'), findsOneWidget);
    expect(find.text('YOUR ZONE'), findsOneWidget);
    expect(find.text('13:01:00'), findsOneWidget);
  });

  testWidgets('TerritoryCellDetailScreen (Screen 4) renders cell details and challenge button', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: TerritoryCellDetailScreen(),
      ),
    );

    expect(find.text('Cell#482'), findsOneWidget);
    expect(find.text('Zia colony'), findsOneWidget);
    expect(find.text('@Ibrahim277'), findsOneWidget);
    expect(find.text('Challenge Cell'), findsOneWidget);
  });
}
