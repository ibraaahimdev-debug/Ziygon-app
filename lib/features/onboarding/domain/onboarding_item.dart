class OnboardingItem {
  final String headline;
  final String body;
  final int cardIndex;

  const OnboardingItem({
    required this.headline,
    required this.body,
    required this.cardIndex,
  });

  static const List<OnboardingItem> items = [
    OnboardingItem(
      headline: "Track Every Move",
      body:
          "Log your runs, cycles, and daily activities with precision. Monitor your heart rate, pace, and progress in real-time.",
      cardIndex: 0,
    ),
    OnboardingItem(
      headline: "Find Your Tribe",
      body:
          "Join vibrant fitness communities, connect with friends, and share your adventures. Messaging and social discovery built right in.",
      cardIndex: 1,
    ),
    OnboardingItem(
      headline: "Explore the Horizon",
      body:
          "Discover new routes and plan your next big trip with interactive maps. Your journey starts here, wherever the road leads.",
      cardIndex: 2,
    ),
  ];
}
