import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptico/core/UI/color/color.dart';
import 'package:receptico/features/auth/bloc/bloc.dart';

class ScaffoldWithGradientWidget extends StatelessWidget {
  final Widget body;
  const ScaffoldWithGradientWidget({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<AuthBloc>().add(AuthRouteEvent());
        return true;
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                context.color.background.themeGradientTop.safe,
                context.color.background.themeGradientBottom.safe,
              ],
              stops: [0.29, 1.0],
            ),
          ),
          child: body,
        ),
      ),
    );
  }
}
