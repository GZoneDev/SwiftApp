import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptico/generated/l10n.dart';
import 'package:receptico/core/UI/theme.dart';

import '../bloc/bloc.dart';
import '../widget/widget.dart';

@RoutePage()
class FailPage extends StatelessWidget {
  const FailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localithation = S.of(context);
    final router = AutoRouter.of(context);
    return ScaffoldWithGradientWidget(
      body: Stack(
        alignment: Alignment.center,
        children: [
          ScreenBackgroundWidget(),
          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 350,
                  child: Text(
                    localithation.oopsTitle,
                    textAlign: TextAlign.center,
                    style: context.font.title1Bold,
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 278,
                  height: 50,
                  child: TextButtonWidget(
                    text: localithation.tryAgainButton,
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthRouteEvent());
                      router.back();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
