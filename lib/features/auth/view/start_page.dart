import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:receptico/core/UI/theme.dart';
import 'package:receptico/core/router/router.dart';
import 'package:receptico/features/auth/bloc/auth/auth_bloc.dart';
import 'package:receptico/generated/l10n.dart';

import '../widget/widget.dart';

@RoutePage()
class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    final localization = S.of(context);
    final borderColor = context.color.border.main.safe;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    bool isVisibleCircle = true;
    double size = 1.0, padding = 60.0;

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
            if (isVisibleCircle)
              Positioned(
                top: -91 / size,
                right: -94 / size,
                child: CircleWidget(color: borderColor, radius: 238 / size),
              ),
            if (isVisibleCircle)
              Positioned(
                bottom: -58 / size,
                left: -71 / size,
                child: CircleWidget(color: borderColor, radius: 170 / size),
              ),
            Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: padding),
                      child: SvgPicture.asset(
                        context.assetPath.logo,
                        width: 282 / size,
                        height: 282 / size,
                      ),
                    ),
                    SizedBox(
                      width: 235,
                      child: Text(
                        localization.wantToCookQuestion,
                        textAlign: TextAlign.center,
                        style: context.font.displayLarge,
                      ),
                    ),
                    SizedBox(height: 32 / size),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 278,
                      height: 40,
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
