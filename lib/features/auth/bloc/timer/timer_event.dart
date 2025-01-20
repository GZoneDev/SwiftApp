part of 'timer_bloc.dart';

abstract class TimerEvent {}

class RestoreTimerStart extends TimerEvent {}

class RegisterTimerStart extends TimerEvent {}

class RegisterTimerStop extends TimerEvent {}
