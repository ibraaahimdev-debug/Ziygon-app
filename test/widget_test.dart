import 'package:flutter_test/flutter_test.dart';
import 'package:ziygon/main.dart';

void main() {
  testWidgets('App initializes without errors', (WidgetTester tester) async {
    await tester.pumpWidget(const ZiygonApp());
    expect(find.byType(ZiygonApp), findsOneWidget);
  });
}
