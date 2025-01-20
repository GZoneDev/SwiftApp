import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptico/features/auth/service/timer_service.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Talker loger;
  final ITimer restoreTimer;
  final ITimer registerTimer;

  TimerBloc({
    required this.restoreTimer,
    required this.registerTimer,
    required this.loger,
  }) : super(TimerInitial()) {
    on<RestoreTimerStart>(_passwordRestoreTimer);
    on<RegisterTimerStart>(_registerVerificationTimer);
    on<RegisterTimerStop>(_registerTimerStop);
  }

  Future<void> _passwordRestoreTimer(
      RestoreTimerStart event, Emitter<TimerState> emit) async {
    try {
      await emit.forEach<int>(
        restoreTimer.stream,
        onData: (remainingSeconds) => RestoreTimerUpdated(remainingSeconds),
      );
      emit(RestoreTimerComplete());
    } catch (e) {
      loger.error('Error occurred in restore timer: $e');
    }
  }

  Future<void> _registerVerificationTimer(
      RegisterTimerStart event, Emitter<TimerState> emit) async {
    try {
      await emit.forEach<int>(
        registerTimer.stream,
        onData: (remainingSeconds) => RegisterTimerUpdated(remainingSeconds),
      );
      emit(RegisterTimerComplete());
    } catch (e) {
      loger.error('Error occurred in register timer: $e');
    }
  }

  Future<void> _registerTimerStop(
          RegisterTimerStop event, Emitter<TimerState> emit) async =>
      await registerTimer.stop();
}
