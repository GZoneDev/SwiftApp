import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptico/core/UI/theme.dart';
import 'package:receptico/features/auth/bloc/auth_bloc.dart';
import 'package:receptico/features/auth/widget/text_button_widget.dart';

class TimerButtonWidget extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  const TimerButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  State<TimerButtonWidget> createState() => _TimerButtonWidgetState();
}

class _TimerButtonWidgetState extends State<TimerButtonWidget> {
  late bool isVisibleButton = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        String time = '';

        if (state is AuthCountdownUpdatedState) {
          time = _formatTime(state.remainingSeconds);
        } else if (state is AuthCountdownCompleteState) {
          time = '';
          isVisibleButton = true;
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isVisibleButton)
              TextButtonWidget(
                width: 278,
                height: 50,
                text: widget.text,
                onPressed: () {
                  setState(() {
                    isVisibleButton = false;
                  });
                  widget.onPressed();
                },
              ),
            if (!isVisibleButton)
              Text(
                time,
                style: context.font.title1,
              ),
          ],
        );
      },
    );
  }

  String _formatTime(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
