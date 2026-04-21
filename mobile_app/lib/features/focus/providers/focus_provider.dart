import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum FocusState { initial, focused, paused, completed }

final focusProvider = StateNotifierProvider<FocusNotifier, FocusModel>((ref) {
  return FocusNotifier();
});

class FocusModel {
  final int totalSeconds;
  final int remainingSeconds;
  final FocusState status;
  final String? currentTaskId;

  FocusModel({
    required this.totalSeconds,
    required this.remainingSeconds,
    required this.status,
    this.currentTaskId,
  });

  FocusModel copyWith({
    int? totalSeconds,
    int? remainingSeconds,
    FocusState? status,
    String? currentTaskId,
  }) {
    return FocusModel(
      totalSeconds: totalSeconds ?? this.totalSeconds,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      status: status ?? this.status,
      currentTaskId: currentTaskId ?? this.currentTaskId,
    );
  }

  double get progress => totalSeconds == 0 ? 0 : 1 - (remainingSeconds / totalSeconds);
}

class FocusNotifier extends StateNotifier<FocusModel> {
  Timer? _timer;

  FocusNotifier() : super(FocusModel(
    totalSeconds: 25 * 60,
    remainingSeconds: 25 * 60,
    status: FocusState.initial,
  ));

  void startFocus({String? taskId, int? durationMinutes}) {
    _timer?.cancel();
    final total = (durationMinutes ?? 25) * 60;
    
    state = state.copyWith(
      totalSeconds: total,
      remainingSeconds: total,
      status: FocusState.focused,
      currentTaskId: taskId,
    );

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingSeconds > 0) {
        state = state.copyWith(remainingSeconds: state.remainingSeconds - 1);
      } else {
        _completeFocus();
      }
    });
  }

  void pauseFocus() {
    _timer?.cancel();
    state = state.copyWith(status: FocusState.paused);
  }

  void resumeFocus() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingSeconds > 0) {
        state = state.copyWith(remainingSeconds: state.remainingSeconds - 1);
      } else {
        _completeFocus();
      }
    });
    state = state.copyWith(status: FocusState.focused);
  }

  void resetFocus() {
    _timer?.cancel();
    state = FocusModel(
      totalSeconds: 25 * 60,
      remainingSeconds: 25 * 60,
      status: FocusState.initial,
    );
  }

  void _completeFocus() {
    _timer?.cancel();
    state = state.copyWith(status: FocusState.completed, remainingSeconds: 0);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

