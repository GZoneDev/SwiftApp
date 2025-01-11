import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptico/core/UI/theme.dart';
import 'package:receptico/features/auth/bloc/bloc.dart';
import 'package:receptico/generated/l10n.dart';

mixin ShowTimerDialogueMixin<T extends StatefulWidget> on State<T> {
  String _formatTime(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void showTimedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).tryAgainMessage),
          content: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            String time = '';

            if (state is AuthCountdownUpdatedState) {
              time = _formatTime(state.remainingSeconds);
            } else if (state is AuthCountdownCompleteState) {
              time = '';
              Navigator.of(context).pop();
            }

            return Text(
              time,
              style: context.font.title2?.copyWith(
                color: context.color.font.hint,
              ),
            );
          }),
        );
      },
    );
  }
}
