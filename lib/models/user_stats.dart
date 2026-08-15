/// Home-screen stats block (streak / accuracy / cards studied).
class UserStats {
  final String displayName;
  final int dayStreak;
  final double accuracyPercent;
  final int cardsStudied;

  const UserStats({
    required this.displayName,
    required this.dayStreak,
    required this.accuracyPercent,
    required this.cardsStudied,
  });
}
