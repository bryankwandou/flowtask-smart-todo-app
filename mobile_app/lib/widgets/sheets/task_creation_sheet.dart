import 'package:flowtask/core/theme/colors.dart';
import 'package:flowtask/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../features/tasks/providers/task_provider.dart';

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
    final l10n = AppLocalizations.of(context)!;

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
            Text(l10n.newTask, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 24),
            
            TextField(
              controller: _titleController,
              autofocus: true,
              style: const TextStyle(fontSize: 18, color: Colors.white),
              decoration: InputDecoration(hintText: l10n.taskHint),
            ),
            const SizedBox(height: 16),
            
            TextField(
              controller: _descController,
              maxLines: 2,
              style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
              decoration: InputDecoration(hintText: l10n.detailsHint),
            ),
            
            const SizedBox(height: 24),
            Text(l10n.priority.toUpperCase(), style: const TextStyle(color: AppColors.textMuted, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.2)),
            const SizedBox(height: 12),
            Row(
              children: [
                _PrioritySelector(label: l10n.lowPriority.toUpperCase(), val: 1, current: _priority, color: AppColors.secondary, onTap: (v) async {
                  await HapticFeedback.lightImpact();
                  setState(() => _priority = v);
                }),
                const SizedBox(width: 8),
                _PrioritySelector(label: l10n.medPriority.toUpperCase(), val: 2, current: _priority, color: AppColors.warning, onTap: (v) async {
                  await HapticFeedback.lightImpact();
                  setState(() => _priority = v);
                }),
                const SizedBox(width: 8),
                _PrioritySelector(label: l10n.highPriority.toUpperCase(), val: 3, current: _priority, color: AppColors.error, onTap: (v) async {
                  await HapticFeedback.selectionClick();
                  setState(() => _priority = v);
                }),
              ],
            ),
            
            const SizedBox(height: 24),
            InkWell(
              onTap: () async {
                  await HapticFeedback.selectionClick();
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _deadline,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (date != null) {
                    await HapticFeedback.lightImpact();
                    setState(() => _deadline = date);
                  }
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
              onPressed: () async {
                if (_titleController.text.isNotEmpty) {
                  await HapticFeedback.mediumImpact();
                  await ref.read(taskProvider.notifier).addTask(
                    _titleController.text,
                    _descController.text,
                    _priority,
                    _deadline,
                  );
                  if (context.mounted) Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
              child: Text(l10n.createTask.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrioritySelector extends StatelessWidget {

  const _PrioritySelector({required this.label, required this.val, required this.current, required this.color, required this.onTap});
  final String label;
  final int val;
  final int current;
  final Color color;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = val == current;
    return GestureDetector(
      onTap: () => onTap(val),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.2) : Colors.transparent,
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
