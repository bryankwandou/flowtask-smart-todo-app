class ProductivityStats {
  final int totalTasks;
  final int completedTasks;
  final int currentStreak;
  final double completionRate;
  final String peakHour;
  final List<double> weeklyVelocity;

  ProductivityStats({
    required this.totalTasks,
    required this.completedTasks,
    required this.currentStreak,
    required this.completionRate,
    required this.peakHour,
    required this.weeklyVelocity,
  });

  factory ProductivityStats.initial() {
    return ProductivityStats(
      totalTasks: 0,
      completedTasks: 0,
      currentStreak: 0,
      completionRate: 0.0,
      peakHour: 'N/A',
      weeklyVelocity: List.filled(7, 0.0),
    );
  }
}
