import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptico/core/UI/theme.dart';
import 'package:receptico/features/auth/bloc/auth_bloc.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return state is AuthLoadingState
            ? AbsorbPointer(
                absorbing: true,
                child: Stack(
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        color:
                            context.color.background.hint.safe.withOpacity(0.3),
                      ),
                    ),
                    Center(
                      child: CircularProgressIndicator(
                        color: context.color.border.hint.safe,
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
