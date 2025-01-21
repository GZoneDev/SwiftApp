import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptico/core/UI/theme.dart';
import 'package:receptico/features/auth/bloc/auth/auth_bloc.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final colorBackground =
            context.color.background.hint.safe.withOpacity(0.3);
        final colorCircular = context.color.border.hint.safe;
        return state is AuthLoadingState
            ? AbsorbPointer(
                absorbing: true,
                child: Stack(
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        color: colorBackground,
                      ),
                    ),
                    Center(
                      child: CircularProgressIndicator(
                        color: colorCircular,
                        strokeWidth: 5,
                        strokeAlign: 5,
                      ),
                    ),
                  ],
                ),
              )
            : SizedBox.shrink();
      },
    );
  }
}
