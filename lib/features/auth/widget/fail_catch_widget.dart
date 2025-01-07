import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptico/core/router/router.dart';
import 'package:receptico/features/auth/bloc/auth_bloc.dart';

class FailCatchWidget extends StatelessWidget {
  const FailCatchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthNetworkFailState) {
          router.navigate(const FailRoute());
        }
      },
      child: SizedBox.shrink(),
    );
  }
}
