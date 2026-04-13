import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/colors.dart';
import '../models/task_model.dart';
import '../providers/task_provider.dart';

class TaskDetailScreen extends ConsumerWidget {
  final Task task;
  const TaskDetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Task Detail', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded, color: AppColors.error),
            onPressed: () {
              ref.read(taskProvider.notifier).deleteTask(task.id);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: task.status == 'completed' ? AppColors.secondary.withOpacity(0.1) : AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                   Icon(
                     task.status == 'completed' ? Icons.check_circle_outline : Icons.pending_outlined,
                     size: 16,
                     color: task.status == 'completed' ? AppColors.secondary : AppColors.primary,
                   ),
                   const SizedBox(width: 8),
                   Text(
                     task.status.toUpperCase(),
                     style: TextStyle(
                       color: task.status == 'completed' ? AppColors.secondary : AppColors.primary,
                       fontSize: 12,
                       fontWeight: FontWeight.bold,
                       letterSpacing: 1.2,
                     ),
                   ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            Text(
              task.title,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white, height: 1.2),
            ),
            
            const SizedBox(height: 16),
            
            Text(
              task.description.isEmpty ? 'No description provided.' : task.description,
              style: const TextStyle(fontSize: 16, color: AppColors.textSecondary, height: 1.5),
            ),
            
            const SizedBox(height: 48),
            
            _buildInfoRow(Icons.calendar_today_rounded, 'Due Date', DateFormat('EEEE, MMMM dd, yyyy').format(task.deadline)),
            const Divider(color: Colors.white10, height: 48),
            _buildInfoRow(Icons.priority_high_rounded, 'Priority', _getPriorityLabel(task.priority)),
            const Divider(color: Colors.white10, height: 48),
            _buildInfoRow(Icons.add_to_photos_outlined, 'Created', DateFormat('MMM dd, yyyy HH:mm').format(task.createdAt)),
            
            const SizedBox(height: 60),
            
            ElevatedButton(
              onPressed: () {
                ref.read(taskProvider.notifier).toggleTaskStatus(task.id);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: task.status == 'completed' ? AppColors.surface : AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 64),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 0,
              ),
              child: Text(
                task.status == 'completed' ? 'MARK AS PENDING' : 'COMPLETE TASK',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: AppColors.primaryLight, size: 20),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }

  String _getPriorityLabel(int p) {
    if (p == 3) return 'High Priority';
    if (p == 2) return 'Medium Priority';
    return 'Low Priority';
  }
}
