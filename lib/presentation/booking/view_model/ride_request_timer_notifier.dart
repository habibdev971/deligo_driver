import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CancelButtonTimerState {
  final int remainingSeconds;
  final bool isButtonEnabled;

  CancelButtonTimerState({
    required this.remainingSeconds,
    required this.isButtonEnabled,
  });

  CancelButtonTimerState copyWith({
    int? remainingSeconds,
    bool? isButtonEnabled,
  }) => CancelButtonTimerState(
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
    );
}

class CancelButtonEnableTimerNotifier extends StateNotifier<CancelButtonTimerState> {
  final Ref ref;
  Timer? _timer;

  static const int _initialDuration = 300; // 5 minutes

  CancelButtonEnableTimerNotifier(this.ref)
      : super(CancelButtonTimerState(
    remainingSeconds: 0,
    isButtonEnabled: false,
  ));

  void startTimer() {

    _timer?.cancel();
    state = state.copyWith(
      remainingSeconds: _initialDuration,
      isButtonEnabled: false,
    );

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final currentSeconds = state.remainingSeconds;

      if (currentSeconds > 1) {
        state = state.copyWith(remainingSeconds: currentSeconds - 1);
      } else {
        timer.cancel();
        state = state.copyWith(
          remainingSeconds: 0,
          isButtonEnabled: true,
        );
      }
    });
  }

  void cancelTimer() {
    _timer?.cancel();
    state = state.copyWith(
      remainingSeconds: 0,
      isButtonEnabled: false,
    );
  }

  void stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    state = state.copyWith(
      remainingSeconds: 0,
      isButtonEnabled: true,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
