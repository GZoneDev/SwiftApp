import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptico/core/UI/color/color_theme.dart';
import 'package:receptico/core/UI/font/font_theme.dart';
import 'package:receptico/core/router/router.dart';
import 'package:receptico/generated/l10n.dart';

import '../bloc/bloc.dart';
import '../widget/widget.dart';

@RoutePage()
class RestoreEmailPage extends StatefulWidget {
  const RestoreEmailPage({super.key});

  @override
  State<RestoreEmailPage> createState() => _RestoreEmailPageState();
}

class _RestoreEmailPageState extends State<RestoreEmailPage> {
  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    final localithation = S.of(context);
    return Scaffold(
      body: Stack(
        children: [
          const ScreenBackgroundWidget(),
          Container(
            alignment: Alignment.center,
            child: SizedBox(
              width: 350,
              height: 458,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      localithation.restorePasswordButton,
                      style: context.font.title1Bold,
                    ),
                    const SizedBox(height: 32),
                    Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                        width: double.infinity,
                        height: 152,
                        decoration: BoxDecoration(
                          color: context.color.background.dashboarEmail,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: context.color.border.dashboarEmail.safe,
                              width: 1),
                        ),
                        child: BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            //Додати ініціалізацію email
                            return Text(
                              textAlign: TextAlign.center,
                              localithation.restoreEmailMessage('email'),
                            );
                          },
                        )),
                    const SizedBox(height: 22),
                    Container(
                      width: 278,
                      alignment: Alignment.center,
                      child: BackLinkWidget(
                        text: localithation.returnToLoginLink,
                        onTap: () => router.navigate(const LoginRoute()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
