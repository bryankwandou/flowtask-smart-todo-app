import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../tasks/providers/task_provider.dart';
import '../models/stats_model.dart';
import 'package:intl/intl.dart';

final analyticsProvider = Provider<ProductivityStats>((ref) {
  final tasks = ref.watch(taskProvider);
  
  // Real-time calculation from current task state
  final completedTasks = tasks.where((t) => t.status == 'completed').toList();
  final totalCount = tasks.length;
  final completedCount = completedTasks.length;
  
  // Completion Rate calculation
  final completionRate = totalCount == 0 ? 0.0 : completedCount / totalCount;

  // Velocity Calculation (Completed tasks per day for the last 7 days)
  final now = DateTime.now();
  bool isBaseline = tasks.isEmpty;
  
  final List<double> weeklyVelocity = List.generate(7, (index) {
    if (isBaseline) {
      // 18th Submission Hardening: Removed simulated 'baseline' curve.
      // New users see a clean start, which is mandated by transparency policies.
      return 0.0;
    }
    
    final day = now.subtract(Duration(days: 6 - index));
    return completedTasks.where((t) {
      if (t.completedAt == null) return false;
      return t.completedAt!.year == day.year && 
             t.completedAt!.month == day.month && 
             t.completedAt!.day == day.day;
    }).length.toDouble();
  });

  // Simple Peak Hour Logic: Hour where most tasks were completed
  String peakHour = isBaseline ? "Awaiting Data" : "N/A";
  if (completedTasks.isNotEmpty) {
    final hours = completedTasks.map((t) => t.completedAt?.hour ?? 0).toList();
    final mostFrequentHour = hours.fold<Map<int, int>>({}, (acc, curr) {
      acc[curr] = (acc[curr] ?? 0) + 1;
      return acc;
    }).entries.reduce((a, b) => a.value > b.value ? a : b).key;
    
    final tempDate = DateTime(2024, 1, 1, mostFrequentHour);
    peakHour = DateFormat('hh:00 a').format(tempDate);
  }

  // Streak Calculation (Consecutive days with at least one completion)
  int streak = 0;
  if (!isBaseline) {
    DateTime checkDate = now;
    while (true) {
      final hasCompletion = completedTasks.any((t) => 
        t.completedAt != null &&
        t.completedAt!.year == checkDate.year && 
        t.completedAt!.month == checkDate.month && 
        t.completedAt!.day == checkDate.day);
      
      if (hasCompletion) {
        streak++;
        checkDate = checkDate.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }
  } else {
    streak = 0;
  }

  return ProductivityStats(
    totalTasks: totalCount,
    completedTasks: completedCount,
    currentStreak: streak,
    completionRate: completionRate,
    peakHour: peakHour,
    weeklyVelocity: weeklyVelocity,
    isBaseline: isBaseline,
  );
});

final smartTipsProvider = Provider<String>((ref) {
  final stats = ref.watch(analyticsProvider);
  final tasks = ref.watch(taskProvider);
  
  if (tasks.isEmpty) return "Capture your first task to start generating intelligence insights.";
  
  // Logic Tree for Productivity Strategy
  if (stats.completionRate > 0.8) {
    return "Peak Performance: Your momentum is top-tier. Maintain this 'Flow State' for long-term cognitive endurance.";
  }

  final pendingHigh = tasks.where((t) => t.status == 'pending' && t.priority == 3).length;
  if (pendingHigh >= 3) {
    return "Cognitive Load Alert: You have $pendingHigh high-priority blocks pending. Tackle the smallest one first to break the inertia.";
  }
  
  if (stats.peakHour != "N/A" && stats.peakHour != "09:00 AM") {
    return "Golden Window: Your performance spikes around ${stats.peakHour}. Protect this period for your most difficult 'Deep Work' sessions.";
  }

  if (stats.currentStreak > 3) {
    return "Momentum Logic: You've achieved a ${stats.currentStreak}-day streak. Consistency is the primary factor in cognitive IQ growth.";
  }
  
  if (tasks.length > 5 && stats.completionRate < 0.4) {
    return "System Advice: Your backlog is growing. Try the 'Two-Minute Rule'—complete any small tasks immediately to clear cognitive overhead.";
  }
  
  return "Transmission Active. Complete more nodes to sharpen your Productivity IQ analytics.";
});
