import 'package:confetti/confetti.dart';
import 'package:flowtask/core/theme/colors.dart';
import 'package:flowtask/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../widgets/sheets/task_creation_sheet.dart';
import '../../../widgets/shimmer_loading.dart';
import '../../analytics/providers/analytics_provider.dart';
import '../models/task_model.dart';
import '../providers/task_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String _searchQuery = '';
  int? _filterPriority; // null = All
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _onTaskCompleted() {
    _confettiController.play();
    HapticFeedback.heavyImpact();
  }

  @override
  Widget build(BuildContext context) {
    final allTasks = ref.watch(taskProvider);
    final isLoading = allTasks.isEmpty && !ref.watch(taskProvider.notifier).mounted; 
    final l10n = AppLocalizations.of(context)!;

    // Apply filtering and search
    final tasks = allTasks.where((t) {
      final matchesSearch = t.title.toLowerCase().contains(_searchQuery) || 
                            t.description.toLowerCase().contains(_searchQuery);
      final matchesPriority = _filterPriority == null || t.priority == _filterPriority;
      return matchesSearch && matchesPriority;
    }).toList();

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar.large(
                expandedHeight: 220,
                stretch: true,
                pinned: true,
                backgroundColor: AppColors.background,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(l10n.appTitle, style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: -0.5)),
                  centerTitle: false,
                  titlePadding: const EdgeInsets.only(left: 24, bottom: 65),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [AppColors.primaryDark, AppColors.background],
                          ),
                        ),
                      ),
                      Positioned(
                        top: -50,
                        right: -50,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary.withValues(alpha: 0.1),
                          ),
                        ).animate().scale(duration: 2.seconds, curve: Curves.easeInOut),
                      ),
                      Positioned(
                        bottom: 70,
                        left: 24,
                        right: 24,
                        child: Consumer(
                          builder: (context, ref, child) {
                            final stats = ref.watch(analyticsProvider);
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildIQStat(l10n.todayLabel, '${tasks.where((t) => t.status == 'completed').length}/${allTasks.length}'),
                                _buildIQStat(l10n.flowIQ, '${(stats.completionRate * 100).toInt()}%'),
                                _buildIQStat(l10n.streakLabel, '${stats.currentStreak}D'),
                              ],
                            );
                          },
                        ),
                      ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2, end: 0),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          child: TextField(
                            onChanged: (val) => setState(() => _searchQuery = val.toLowerCase()),
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                            decoration: InputDecoration(
                              hintText: l10n.searchHint,
                              hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
                              prefixIcon: Icon(Icons.search_rounded, color: Colors.white.withValues(alpha: 0.3), size: 18),
                              filled: true,
                              fillColor: Colors.white.withValues(alpha: 0.05),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: IconButton.filledTonal(
                      onPressed: () async {
                        await HapticFeedback.lightImpact();
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(l10n.focusDefense),
                            backgroundColor: AppColors.primary,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        );
                      },
                      icon: const Icon(Icons.notifications_none_rounded, color: AppColors.primaryLight),
                    ),
                  ),
                ],
              ),

              // Filter Chips
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Row(
                    children: [
                       _buildFilterChip(l10n.allFilter, null),
                       const SizedBox(width: 8),
                       _buildFilterChip('🔥 ${l10n.highPriority}', 3),
                       const SizedBox(width: 8),
                       _buildFilterChip('⚡ ${l10n.medPriority}', 2),
                       const SizedBox(width: 8),
                       _buildFilterChip('🍀 ${l10n.lowPriority}', 1),
                    ],
                  ),
                ),
              ),

              if (isLoading)
                const SliverFillRemaining(child: ShimmerTaskList())
              else if (tasks.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.05),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.auto_awesome_rounded, size: 64, color: AppColors.primaryLight),
                        ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                         .scale(duration: 2.seconds, begin: const Offset(0.9, 0.9), end: const Offset(1.1, 1.1), curve: Curves.easeInOutQuad)
                         .shimmer(duration: 3.seconds, color: Colors.white10),
                        const SizedBox(height: 32),
                        Text(
                          _searchQuery.isEmpty ? l10n.emptyState : l10n.noMatchingTasks,
                          style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: -0.5)
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _searchQuery.isEmpty ? l10n.captureGoal : l10n.adjustFilters,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: AppColors.textMuted)
                        ),
                      ],
                    ).animate().fadeIn(duration: 800.ms),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final Task task = tasks[index];
                        return _TaskCard(task: task, onCompleted: _onTaskCompleted, l10n: l10n)
                            .animate(delay: (index * 100).ms)
                            .fadeIn(duration: 500.ms)
                            .slideX(begin: 0.1, end: 0, curve: Curves.easeOutCubic);
                      },
                      childCount: tasks.length,
                    ),
                  ),
                ),
            ],
          ),
          
          // Confetti overlay
          IgnorePointer(
            child: Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                colors: const [AppColors.primary, AppColors.secondary, Colors.amber, Colors.white],
                gravity: 0.3,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () => _showAddTaskSheet(context),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add_rounded, size: 36, color: Colors.white),
      ).animate().scale(delay: 600.ms, duration: 400.ms, curve: Curves.elasticOut),
    );
  }

  Widget _buildFilterChip(String label, int? priority) {
    final isSelected = _filterPriority == priority;
    return ChoiceChip(
      label: Text(label, style: TextStyle(fontSize: 12, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
      selected: isSelected,
      onSelected: (val) async {
        await HapticFeedback.lightImpact();
        setState(() => _filterPriority = val ? priority : null);
      },
      selectedColor: AppColors.primary.withValues(alpha: 0.2),
      backgroundColor: Colors.white.withValues(alpha: 0.05),
      labelStyle: TextStyle(color: isSelected ? AppColors.primaryLight : Colors.white70),
      side: BorderSide(color: isSelected ? AppColors.primary : Colors.transparent),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  Widget _buildIQStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),
        const SizedBox(height: 4),
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(milliseconds: 1200),
          curve: Curves.easeOutQuart,
          builder: (context, val, child) => Opacity(
            opacity: val,
            child: Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: -1)),
          ),
        ),
      ],
    );
  }

  void _showAddTaskSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const TaskCreationSheet(),
    );
  }
}

class _TaskCard extends ConsumerWidget {
  const _TaskCard({required this.task, required this.onCompleted, required this.l10n});
  final Task task;
  final VoidCallback onCompleted;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCompleted = task.status == 'completed';

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Dismissible(
        key: Key(task.id),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 24),
          decoration: BoxDecoration(
            color: AppColors.error.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Icon(Icons.delete_sweep_rounded, color: Colors.white, size: 28),
        ),
        onDismissed: (_) async {
          await HapticFeedback.lightImpact();
          await ref.read(taskProvider.notifier).deleteTask(task.id);
        },
        child: GestureDetector(
          onTap: () async {
            await HapticFeedback.lightImpact();
            if (context.mounted) await context.push('/task-detail', extra: task);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isCompleted ? Colors.white.withValues(alpha: 0.02) : Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: isCompleted ? Colors.white.withValues(alpha: 0.05) : Colors.white.withValues(alpha: 0.12), 
                width: 1
              ),
              boxShadow: isCompleted ? [] : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10)
                )
              ],
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    await HapticFeedback.mediumImpact();
                    if (!isCompleted) {
                      onCompleted();
                    }
                    await ref.read(taskProvider.notifier).toggleTaskStatus(task.id);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isCompleted ? AppColors.secondary : Colors.transparent,
                      border: Border.all(
                        color: isCompleted ? AppColors.secondary : Colors.white24, 
                        width: 2
                      ),
                    ),
                    child: isCompleted ? const Icon(Icons.check_rounded, size: 18, color: Colors.white) : null,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isCompleted ? AppColors.textMuted : Colors.white,
                          decoration: isCompleted ? TextDecoration.lineThrough : null,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(Icons.schedule_rounded, size: 12, color: isCompleted ? Colors.transparent : AppColors.textMuted),
                          const SizedBox(width: 4),
                          Text(
                            DateFormat('h:mm a').format(task.deadline), 
                            style: const TextStyle(color: AppColors.textMuted, fontSize: 12, fontWeight: FontWeight.w500)
                          ),
                          const SizedBox(width: 16),
                          _PriorityBadge(priority: task.priority, l10n: l10n),
                        ],
                      ),
                    ],
                  ),
                ),
                if (!isCompleted)
                  const Icon(Icons.chevron_right_rounded, color: Colors.white12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PriorityBadge extends StatelessWidget {
  const _PriorityBadge({required this.priority, required this.l10n});
  final int priority;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;
    if (priority == 3) {
      color = AppColors.error;
      label = l10n.highPriority.toUpperCase();
    } else if (priority == 2) {
      color = AppColors.warning;
      label = l10n.medPriority.toUpperCase();
    } else {
      color = AppColors.secondary;
      label = l10n.lowPriority.toUpperCase();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1), 
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.2), width: 0.5),
      ),
      child: Text(
        label, 
        style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 1)
      ),
    );
  }
}
