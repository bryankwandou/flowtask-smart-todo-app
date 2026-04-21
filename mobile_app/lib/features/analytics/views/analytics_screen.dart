import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flowtask/core/theme/colors.dart';
import '../providers/analytics_provider.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(analyticsProvider);

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverAppBar.medium(
            title: Text('Productivity IQ', style: TextStyle(fontWeight: FontWeight.bold)),
            centerTitle: false,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  // Intelligence Score Bar
                  _buildIQHeader(stats.currentStreak),
                  const SizedBox(height: 32),

                  _buildSectionTitle('Weekly Performance'),
                  const SizedBox(height: 16),
                  _buildWeeklyChart(stats.weeklyVelocity),
                  
                  const SizedBox(height: 32),
                  _buildSectionTitle('Cognitive Focus Patterns'),
                  const SizedBox(height: 16),
                  _buildPatternsGrid(stats),
                  
                  const SizedBox(height: 32),
                  _buildProductivityInsightCard(stats.peakHour),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIQHeader(int streak) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Current Streak', style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text('${streak.toString().padLeft(2, '0')} Days', style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800)),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(16)),
            child: const Icon(Icons.bolt_rounded, color: Colors.amber, size: 32),
          ),
        ],
      ),
    ).animate().slideY(begin: 0.2, end: 0, duration: 600.ms, curve: Curves.easeOutQuart).fadeIn();
  }

  Widget _buildWeeklyChart(List<double> velocity) {
    return RepaintBoundary(
      child: Container(
        height: 240,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white10),
        ),
        child: LineChart(
          LineChartData(
            gridData: const FlGridData(show: false),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (val, _) {
                    const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                    if (val.toInt() >= 0 && val.toInt() < 7) {
                      return Text(days[val.toInt()], style: const TextStyle(color: AppColors.textMuted, fontSize: 12));
                    }
                    return const Text('');
                  },
                ),
              ),
              leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: velocity.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList(),
                isCurved: true,
                color: AppColors.primary,
                barWidth: 4,
                isStrokeCapRound: true,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.primary.withValues(alpha: 0.2), Colors.transparent],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: 200.ms, duration: 800.ms);
  }

  Widget _buildPatternsGrid(dynamic stats) {
    return Column(
      children: [
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.4,
          children: [
            _buildStatCard('Total Tasks', stats.totalTasks.toString(), Icons.check_circle_outline, AppColors.primary),
            _buildStatCard('Current Streak', '${stats.currentStreak} Days', Icons.local_fire_department_rounded, AppColors.warning),
            _buildStatCard('Completion', '${(stats.completionRate * 100).toInt()}%', Icons.pie_chart_outline_rounded, AppColors.secondary),
            _buildStatCard('Peak Hour', stats.peakHour, Icons.access_time_rounded, AppColors.primaryLight),
          ],
        ).animate().fadeIn(delay: 400.ms),

        const SizedBox(height: 32),

        // Intelligence Tip Card
        Consumer(
          builder: (context, ref, child) {
            final tip = ref.watch(smartTipsProvider);
            return Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary.withValues(alpha: 0.1), AppColors.secondary.withValues(alpha: 0.05)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.psychology_outlined, color: AppColors.primaryLight, size: 32),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('INTELLIGENCE TIP', style: TextStyle(color: AppColors.primaryLight, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                        const SizedBox(height: 4),
                        Text(tip, style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.4)),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().shimmer(duration: 2.seconds, color: Colors.white10).fadeIn(delay: 500.ms);
          },
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 18),
          const Spacer(),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
        ],
      ),
    ).animate().shimmer(duration: 2.seconds, color: Colors.white10);
  }

  Widget _buildPatternTile(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.textMuted, size: 18),
          const Spacer(),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
        ],
      ),
    );
  }

  Widget _buildProductivityInsightCard(String peakHour) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.secondary.withValues(alpha: 0.1), Colors.transparent]),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.secondary.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.lightbulb_outline, color: AppColors.secondary),
              SizedBox(width: 12),
              Text('Smart Recommendation', style: TextStyle(color: AppColors.secondary, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Your productivity typically peaks around $peakHour. Schedule your high-priority "Deep Work" tasks during this window for 30% higher efficiency.',
            style: TextStyle(color: AppColors.textPrimary.withValues(alpha: 0.8), height: 1.5),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 600.ms);
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: -0.5),
    );
  }
}

