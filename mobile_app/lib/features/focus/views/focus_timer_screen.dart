import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:confetti/confetti.dart';
import '../../../core/theme/colors.dart';
import '../providers/focus_provider.dart';

class FocusTimerScreen extends ConsumerStatefulWidget {
  const FocusTimerScreen({super.key});

  @override
  ConsumerState<FocusTimerScreen> createState() => _FocusTimerScreenState();
}

class _FocusTimerScreenState extends ConsumerState<FocusTimerScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final focus = ref.watch(focusProvider);
    final focusNotifier = ref.read(focusProvider.notifier);

    // Trigger confetti on completion
    if (focus.status == FocusState.completed) {
      _confettiController.play();
    }

    String timerText = _formatTime(focus.remainingSeconds);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              colors: const [AppColors.primary, AppColors.secondary, Colors.white],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (focus.currentTaskId != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: const Text(
                      'ACTIVE TASK FOCUS',
                      style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                    ),
                  ).animate().fadeIn().slideY(begin: -0.2, end: 0),
                
                const SizedBox(height: 48),
                
                CircularPercentIndicator(
                  radius: 140.0,
                  lineWidth: 12.0,
                  percent: focus.progress,
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: focus.status == FocusState.completed ? AppColors.secondary : AppColors.primary,
                  backgroundColor: AppColors.surface,
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        timerText,
                        style: const TextStyle(fontSize: 56, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text(
                        focus.status == FocusState.completed ? 'FINISHED' : 'REMAINING',
                        style: const TextStyle(color: AppColors.textMuted, letterSpacing: 2, fontSize: 13),
                      ),
                    ],
                  ),
                  animation: true,
                  animateFromLastPercent: true,
                  animationDuration: 1000,
                ).animate().scale(duration: 800.ms, curve: Curves.elasticOut),
                
                const SizedBox(height: 64),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (focus.status == FocusState.initial || focus.status == FocusState.completed)
                      _buildLargeButton(
                        onPressed: () => focusNotifier.startFocus(),
                        label: 'START SESSION',
                        icon: Icons.play_arrow_rounded,
                        color: AppColors.primary,
                      )
                    else ...[
                      _buildControlCircle(
                        onPressed: () => focusNotifier.resetFocus(),
                        icon: Icons.replay_rounded,
                        color: AppColors.surface,
                      ),
                      const SizedBox(width: 32),
                      _buildControlCircle(
                        onPressed: focus.status == FocusState.focused 
                          ? () => focusNotifier.pauseFocus() 
                          : () => focusNotifier.resumeFocus(),
                        icon: focus.status == FocusState.focused ? Icons.pause_rounded : Icons.play_arrow_rounded,
                        color: AppColors.primary,
                        isLarge: true,
                      ),
                      const SizedBox(width: 32),
                      _buildControlCircle(
                        onPressed: () {
                          focusNotifier.resetFocus();
                          Navigator.pop(context);
                        },
                        icon: Icons.stop_rounded,
                        color: AppColors.error.withOpacity(0.2),
                        iconColor: AppColors.error,
                      ),
                    ]
                  ],
                ).animate().fadeIn(delay: 400.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLargeButton({required VoidCallback onPressed, required String label, required IconData icon, required Color color}) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.1)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
      ),
    );
  }

  Widget _buildControlCircle({required VoidCallback onPressed, required IconData icon, required Color color, Color iconColor = Colors.white, bool isLarge = false}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: EdgeInsets.all(isLarge ? 24 : 16),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: color == AppColors.surface ? Border.all(color: Colors.white10) : null,
        ),
        child: Icon(icon, color: iconColor, size: isLarge ? 32 : 24),
      ),
    );
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
