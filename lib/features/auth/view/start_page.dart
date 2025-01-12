import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:receptico/core/UI/theme.dart';
import 'package:receptico/core/router/router.dart';
import 'package:receptico/features/auth/bloc/auth_bloc.dart';
import 'package:receptico/generated/l10n.dart';

import '../widget/widget.dart';

@RoutePage()
class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    final router = AutoRouter.of(context);
    final localization = S.of(context);
    final borderColor = context.color.border.main.safe;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthNetworkFailState) {
          router.navigate(const FailRoute());
        }
      },
      child: ScaffoldWithGradientWidget(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: -91,
              right: -94,
              child: CircleWidget(color: borderColor, width: 238, height: 238),
            ),
            Positioned(
              bottom: -58,
              left: -71,
              child: CircleWidget(color: borderColor, width: 170, height: 170),
            ),
            Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                        bottom: orientation == Orientation.portrait ? 60.0 : 0,
                      ),
                      child: SvgPicture.asset(
                        context.assetPath.logo,
                        width: 282,
                        height: 282,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 34.0),
                      child: SizedBox(
                        width: 235,
                        child: Text(
                          localization.wantToCookQuestion,
                          textAlign: TextAlign.center,
                          style: context.font.displayLarge,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 278,
                      height: 50,
                      child: TextButton(
                        onPressed: () => router.navigate(const LoginRoute()),
                        child: Text(localization.loginButton),
                      ),
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () => router.navigate(const RegisterRoute()),
                      child: Text(
                        localization.registerLink,
                        style: context.font.headline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
