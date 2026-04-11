import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/colors.dart';
import '../providers/task_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);
    final pendingTasks = tasks.where((t) => t.status != 'completed').toList();
    final completedTasks = tasks.where((t) => t.status == 'completed').toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Daily Flow', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {},
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Focus on what matters.',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  if (pendingTasks.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Text('All caught up! Time to flow.', style: TextStyle(color: Colors.grey)),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final task = pendingTasks[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: GestureDetector(
                        onTap: () => ref.read(taskProvider.notifier).toggleTaskStatus(task.id),
                        child: Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.secondary, width: 2),
                          ),
                        ),
                      ),
                      title: Text(
                        task.title,
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.access_time, size: 14, color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Text(
                              DateFormat('MMM dd, hh:mm a').format(task.deadline),
                              style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                            ),
                            const SizedBox(width: 12),
                            if (task.priority == 3)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.error.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text('High', style: TextStyle(color: AppColors.error, fontSize: 10, fontWeight: FontWeight.bold)),
                              )
                          ],
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.play_circle_fill, color: AppColors.primary, size: 36),
                        onPressed: () {
                          // TODO: Launch Focus Timer for this task
                        },
                      ),
                    ),
                  ),
                );
              },
              childCount: pendingTasks.length,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Completed (${completedTasks.length})',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final task = completedTasks[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  child: ListTile(
                    leading: const Icon(Icons.check_circle, color: AppColors.secondary),
                    title: Text(
                      task.title,
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.undo, color: AppColors.textSecondary),
                      onPressed: () => ref.read(taskProvider.notifier).toggleTaskStatus(task.id),
                    ),
                  ),
                );
              },
              childCount: completedTasks.length,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          // TODO: Open Create Task Bottom Sheet
        },
      ),
    );
  }
}
