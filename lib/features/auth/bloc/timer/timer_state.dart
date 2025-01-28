part of 'timer_bloc.dart';

abstract class TimerState {}

class TimerInitial extends TimerState {}

class RestoreTimerUpdated extends TimerState {
  final int remainingSeconds;
  RestoreTimerUpdated(this.remainingSeconds);
}

class RestoreTimerComplete extends TimerState {}

class RegisterTimerUpdated extends TimerState {
  final int remainingSeconds;
  RegisterTimerUpdated(this.remainingSeconds);
}

class RegisterTimerComplete extends TimerState {}
