import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/colors.dart';
import '../providers/task_provider.dart';

class TaskCreationSheet extends ConsumerStatefulWidget {
  const TaskCreationSheet({super.key});

  @override
  ConsumerState<TaskCreationSheet> createState() => _TaskCreationSheetState();
}

class _TaskCreationSheetState extends ConsumerState<TaskCreationSheet> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  int _priority = 1;
  DateTime _deadline = DateTime.now().add(const Duration(hours: 24));

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        top: 24,
        left: 24,
        right: 24,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2)),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Create New Task', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 24),
            
            TextField(
              controller: _titleController,
              autofocus: true,
              style: const TextStyle(fontSize: 18, color: Colors.white),
              decoration: const InputDecoration(hintText: 'What needs to be done?'),
            ),
            const SizedBox(height: 16),
            
            TextField(
              controller: _descController,
              maxLines: 2,
              style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
              decoration: const InputDecoration(hintText: 'Add some details (optional)'),
            ),
            
            const SizedBox(height: 24),
            const Text('Priority', style: TextStyle(color: AppColors.textMuted, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.2)),
            const SizedBox(height: 12),
            Row(
              children: [
                _PrioritySelector(label: 'LOW', val: 1, current: _priority, color: AppColors.secondary, onTap: (v) => setState(() => _priority = v)),
                const SizedBox(width: 8),
                _PrioritySelector(label: 'MEDIUM', val: 2, current: _priority, color: AppColors.warning, onTap: (v) => setState(() => _priority = v)),
                const SizedBox(width: 8),
                _PrioritySelector(label: 'HIGH', val: 3, current: _priority, color: AppColors.error, onTap: (v) => setState(() => _priority = v)),
              ],
            ),
            
            const SizedBox(height: 24),
            const Text('Deadline', style: TextStyle(color: AppColors.textMuted, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.2)),
            const SizedBox(height: 12),
            InkWell(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _deadline,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (date != null) setState(() => _deadline = date);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.calendar_today_rounded, size: 16, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Text(DateFormat('MMM dd, yyyy').format(_deadline), style: const TextStyle(color: AppColors.textPrimary)),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty) {
                  ref.read(taskProvider.notifier).addTask(
                    _titleController.text,
                    _descController.text,
                    _priority,
                    _deadline,
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('CREATE TASK'),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrioritySelector extends StatelessWidget {
  final String label;
  final int val;
  final int current;
  final Color color;
  final Function(int) onTap;

  const _PrioritySelector({required this.label, required this.val, required this.current, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    bool isSelected = val == current;
    return GestureDetector(
      onTap: () => onTap(val),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? color : Colors.white10),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? color : AppColors.textMuted,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
