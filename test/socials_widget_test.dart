import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ziygon/features/socials/presentation/communities_screen.dart';
import 'package:ziygon/features/socials/presentation/community_detail_screen.dart';
import 'package:ziygon/features/socials/presentation/friends_screen.dart';
import 'package:ziygon/features/socials/presentation/socials_feed_screen.dart';
import 'package:ziygon/features/socials/presentation/user_profile_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('SocialsFeedScreen (Screen 1) renders quick access & feeds', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SocialsFeedScreen()));

    expect(find.text('Quick Access'), findsOneWidget);
    expect(find.text('Feeds'), findsOneWidget);
    expect(find.text('Communities'), findsOneWidget);
  });

  testWidgets('FriendsScreen (Screen 2) renders requests & friends list', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: FriendsScreen()));

    expect(find.text('Friends Request'), findsOneWidget);
    expect(find.text('Friends'), findsOneWidget);
  });

  testWidgets('CommunitiesScreen (Screen 3) renders top communities & your communities', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: CommunitiesScreen()));

    expect(find.text('top Communities'), findsOneWidget);
    expect(find.text('Your communities'), findsOneWidget);
  });

  testWidgets('CommunityDetailScreen (Screen 4) renders Aura Walk details & announcements', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: CommunityDetailScreen()));

    expect(find.text("Aura's Walk"), findsOneWidget);
  });

  testWidgets('UserProfileScreen (Screens 5 & 6) renders user stats & territory map', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: UserProfileScreen()));

    expect(find.text('Ibrahim Amjad'), findsOneWidget);
    expect(find.text('@Ibrahim277'), findsOneWidget);
    expect(find.text('Territory 1.8 km covered'), findsOneWidget);
  });
}
