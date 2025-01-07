import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptico/core/UI/theme.dart';
import 'package:receptico/core/router/router.dart';
import 'package:receptico/generated/l10n.dart';

import '../bloc/bloc.dart';
import '../widget/widget.dart';

@RoutePage()
class SendEmailPage extends StatefulWidget {
  const SendEmailPage({super.key});

  @override
  State<SendEmailPage> createState() => _SendEmailPageState();
}

class _SendEmailPageState extends State<SendEmailPage> {
  String? title, message;

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
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthRestoreSuccessState) {
                      title = localithation.restorePasswordTitle;
                      message = localithation.restoreEmailMessage(state.email);
                    }

                    if (state is AuthRegisterSuccessState) {
                      title = localithation.registerTitle;
                      message = localithation.confirmEmailMessage(state.email);
                    }

                    return Column(
                      children: [
                        Text(
                          title ?? '',
                          style: context.font.title1Bold,
                        ),
                        const SizedBox(height: 32),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 32, horizontal: 16),
                          width: double.infinity,
                          height: 152,
                          decoration: BoxDecoration(
                            color: context.color.background.dashboarEmail.safe,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: context.color.border.dashboarEmail.safe,
                                width: 1),
                          ),
                          child: BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) => Text(
                              textAlign: TextAlign.center,
                              message ?? '',
                            ),
                          ),
                        ),
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
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
