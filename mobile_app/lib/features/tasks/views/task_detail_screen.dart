import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flowtask/core/theme/colors.dart';
import '../models/task_model.dart';
import '../providers/task_provider.dart';

class TaskDetailScreen extends ConsumerStatefulWidget {
  final Task task;
  const TaskDetailScreen({super.key, required this.task});

  @override
  ConsumerState<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends ConsumerState<TaskDetailScreen> {
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

  void _handleToggle() {
    final bool isCompleting = widget.task.status != 'completed';
    HapticFeedback.heavyImpact();
    
    if (isCompleting) {
      _confettiController.play();
    }
    
    ref.read(taskProvider.notifier).toggleTaskStatus(widget.task.id);
  }

  @override
  Widget build(BuildContext context) {
    // Re-fetch task from provider to ensure reactivity after toggle
    final taskState = ref.watch(taskProvider).firstWhere((t) => t.id == widget.task.id, orElse: () => widget.task);
    final isCompleted = taskState.status == 'completed';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Detail Identity', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: -0.5)),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded, color: AppColors.error),
            onPressed: () {
              HapticFeedback.mediumImpact();
              ref.read(taskProvider.notifier).deleteTask(taskState.id);
              Navigator.pop(context);
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status Header
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isCompleted ? AppColors.secondary.withOpacity(0.1) : AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: isCompleted ? AppColors.secondary.withOpacity(0.3) : AppColors.primary.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                       Icon(
                         isCompleted ? Icons.check_circle_outline : Icons.pending_outlined,
                         size: 16,
                         color: isCompleted ? AppColors.secondary : AppColors.primary,
                       ),
                       const SizedBox(width: 8),
                       Text(
                         taskState.status.toUpperCase(),
                         style: TextStyle(
                           color: isCompleted ? AppColors.secondary : AppColors.primary,
                           fontSize: 12,
                           fontWeight: FontWeight.w900,
                           letterSpacing: 1.5,
                         ),
                       ),
                    ],
                  ),
                ).animate().fadeIn().slideX(begin: -0.2, end: 0),
                
                const SizedBox(height: 32),
                
                Text(
                  taskState.title,
                  style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w900, color: Colors.white, height: 1.1, letterSpacing: -1),
                ).animate().fadeIn(delay: 200.ms),
                
                const SizedBox(height: 20),
                
                Text(
                  taskState.description.isEmpty ? 'No detailed transmission provided for this node.' : taskState.description,
                  style: TextStyle(fontSize: 17, color: AppColors.textSecondary, height: 1.6),
                ).animate().fadeIn(delay: 400.ms),
                
                const SizedBox(height: 56),
                
                _buildInfoCard([
                  _buildInfoRow(Icons.calendar_today_rounded, 'Temporal Target', DateFormat('EEEE, MMM dd, yyyy').format(taskState.deadline)),
                  const Divider(color: Colors.white10, height: 48),
                  _buildInfoRow(Icons.priority_high_rounded, 'Priority Tier', _getPriorityLabel(taskState.priority)),
                  const Divider(color: Colors.white10, height: 48),
                  _buildInfoRow(Icons.add_to_photos_outlined, 'Node Creation', DateFormat('MMM dd, yyyy HH:mm').format(taskState.createdAt)),
                ]),
                
                const SizedBox(height: 80),
              ],
            ),
          ),
          
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: ElevatedButton(
                onPressed: _handleToggle,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isCompleted ? AppColors.surface : AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 68),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                  elevation: isCompleted ? 0 : 12,
                  shadowColor: AppColors.primary.withOpacity(0.4),
                ),
                child: Text(
                  isCompleted ? 'RESTORE TO PENDING' : 'COMPLETE TRANSMISSION',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, letterSpacing: 1.5),
                ),
              ),
            ).animate().slideY(begin: 1, end: 0, delay: 600.ms, curve: Curves.easeOutQuart),
          ),

          // Confetti overlay
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              colors: const [AppColors.primary, AppColors.secondary, Colors.amber, Colors.white],
              gravity: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(children: children),
    ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16)),
          child: Icon(icon, color: AppColors.primaryLight, size: 22),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(color: AppColors.textMuted, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
            const SizedBox(height: 6),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  String _getPriorityLabel(int p) {
    if (p == 3) return 'Critical High';
    if (p == 2) return 'Balanced Medium';
    return 'Optimized Low';
  }
}
