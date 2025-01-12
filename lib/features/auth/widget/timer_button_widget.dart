import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptico/core/UI/theme.dart';
import 'package:receptico/features/auth/bloc/auth_bloc.dart';
import 'package:receptico/features/auth/common/function/function_second_to_minute.dart';

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
          time = secondToMinute(state.remainingSeconds);
        } else if (state is AuthCountdownCompleteState) {
          time = '';
          isVisibleButton = true;
        }

        final font = context.font.title1;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isVisibleButton)
              SizedBox(
                width: 278,
                height: 50,
                child: TextButton(
                  onPressed: () {
                    setState(() => isVisibleButton = false);
                    widget.onPressed();
                  },
                  child: Text(widget.text),
                ),
              ),
            if (!isVisibleButton)
              Text(
                time,
                style: font,
              ),
          ],
        );
      },
    );
  }
}
