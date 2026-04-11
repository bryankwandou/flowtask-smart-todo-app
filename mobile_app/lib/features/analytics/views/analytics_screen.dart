import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/colors.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  _buildIQHeader(),
                  const SizedBox(height: 32),

                  _buildSectionTitle('Weekly Performance'),
                  const SizedBox(height: 16),
                  _buildWeeklyChart(),
                  
                  const SizedBox(height: 32),
                  _buildSectionTitle('Cognitive Focus Patterns'),
                  const SizedBox(height: 16),
                  _buildPatternsGrid(),
                  
                  const SizedBox(height: 32),
                  _buildProductivityInsightCard(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIQHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
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
            children: const [
              Text('Current Streak', style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text('08 Days', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.extrabold)),
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

  Widget _buildWeeklyChart() {
    return Container(
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
              spots: [
                const FlSpot(0, 3),
                const FlSpot(1, 1),
                const FlSpot(2, 4),
                const FlSpot(3, 2),
                const FlSpot(4, 5),
                const FlSpot(5, 3),
                const FlSpot(6, 4),
              ],
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
                  colors: [AppColors.primary.withOpacity(0.2), Colors.transparent],
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 200.ms, duration: 800.ms);
  }

  Widget _buildPatternsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.4,
      children: [
        _buildPatternTile('Peak Hour', '10:00 AM', Icons.wb_sunny_outlined),
        _buildPatternTile('Completion', '84%', Icons.check_circle_outline),
        _buildPatternTile('Focus Time', '24.5h', Icons.timer_outlined),
        _buildPatternTile('Deep Work', '12 Sessions', Icons.psychology_outlined),
      ],
    ).animate().slideY(begin: 0.1, end: 0, delay: 400.ms);
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

  Widget _buildProductivityInsightCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.secondary.withOpacity(0.1), Colors.transparent]),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.secondary.withOpacity(0.2)),
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
            'Your productivity peaks in the late morning. Schedule your high-priority "Deep Work" tasks between 10 AM and 12 PM for 30% higher efficiency.',
            style: TextStyle(color: AppColors.textPrimary.withOpacity(0.8), height: 1.5),
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
