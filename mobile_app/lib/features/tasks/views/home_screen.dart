import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/colors.dart';
import '../../../widgets/shimmer_loading.dart';
import '../providers/task_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);
    
    // Simulate a brief loading state if tasks list was theoretically empty/fetching
    // In a real app, you'd watch a 'loading' provider.
    final isLoading = false; 

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Premium Animated App Bar
          SliverAppBar.large(
            expandedHeight: 180,
            stretch: true,
            backgroundColor: AppColors.background,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'FlowTask',
                style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: -0.5),
              ),
              centerTitle: false,
              titlePadding: const EdgeInsets.only(left: 24, bottom: 20),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.primaryDark, AppColors.background],
                  ),
                ),
                child: Opacity(
                  opacity: 0.1,
                  child: Image.network(
                    'https://images.unsplash.com/photo-1484480974693-6ca0a78fb36b?auto=format&fit=crop&q=80&w=1000',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: IconButton.filledTonal(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_none_rounded, color: AppColors.primaryLight),
                ),
              ),
            ],
          ),

          if (isLoading)
            const SliverFillRemaining(child: ShimmerTaskList())
          else if (tasks.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.auto_awesome, size: 64, color: Colors.white12),
                    const SizedBox(height: 16),
                    const Text('Your flow is clear.', style: TextStyle(color: AppColors.textSecondary, fontSize: 18)),
                    const Text('Tap + to start progress.', style: TextStyle(color: AppColors.textMuted)),
                  ],
                ).animate().fadeIn(duration: 800.ms).scale(begin: const Offset(0.9, 0.9)),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final task = tasks[index];
                    return _TaskCard(task: task)
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
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add_rounded, size: 36, color: Colors.white),
      ).animate().scale(delay: 600.ms, duration: 400.ms, curve: Curves.elasticOut),
    );
  }
}

class _TaskCard extends ConsumerWidget {
  final dynamic task;
  const _TaskCard({required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCompleted = task.status == 'completed';

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () => ref.read(taskProvider.notifier).toggleTaskStatus(task.id),
        child: AnimatedContainer(
          duration: 300.ms,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isCompleted ? AppColors.surface.withOpacity(0.5) : AppColors.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isCompleted ? Colors.transparent : Colors.white10,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              // Custom Animated Checkbox
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted ? AppColors.secondary : Colors.transparent,
                  border: Border.all(
                    color: isCompleted ? AppColors.secondary : AppColors.textMuted,
                    width: 2,
                  ),
                ),
                child: isCompleted
                    ? const Icon(Icons.check, size: 20, color: Colors.white)
                    : null,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isCompleted ? AppColors.textMuted : AppColors.textPrimary,
                        decoration: isCompleted ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.timer_outlined, size: 14, color: AppColors.textMuted),
                        const SizedBox(width: 4),
                        Text(
                          DateFormat('hh:mm a').format(task.deadline),
                          style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
                        ),
                        const SizedBox(width: 16),
                        _PriorityBadge(priority: task.priority),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton.filledTonal(
                onPressed: () {},
                icon: const Icon(Icons.play_arrow_rounded, color: AppColors.primaryLight),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PriorityBadge extends StatelessWidget {
  final int priority;
  const _PriorityBadge({required this.priority});

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;
    if (priority == 3) {
      color = AppColors.error;
      label = 'High';
    } else if (priority == 2) {
      color = AppColors.warning;
      label = 'Med';
    } else {
      color = AppColors.secondary;
      label = 'Low';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}
