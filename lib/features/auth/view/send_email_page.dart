import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:receptico/core/UI/theme.dart';
import 'package:receptico/core/FirebaseAuthService/FirebaseAuthManager.dart';
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
  String title = '', message = '';
  VoidCallback onPressed = () {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    final localithation = S.of(context);
    return ScaffoldWithGradientWidget(
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
                    switch (state.runtimeType) {
                      case const (AuthRestoreSuccessState):
                        final s = state as AuthRestoreSuccessState;
                        title = localithation.restorePasswordTitle;
                        message = localithation.restoreEmailMessage(s.email);
                        onPressed = () => context
                            .read<AuthBloc>()
                            .add(AuthSendRestoreEmailEvent(s.email));

                        break;
                      case const (AuthRegisterSuccessState):
                        final s = state as AuthRegisterSuccessState;
                        title = localithation.registerTitle;
                        message = localithation.confirmEmailMessage(s.email);
                        onPressed = () => context
                            .read<AuthBloc>()
                            .add(AuthSendRegisterEmailEvent(s.email));
                        break;
                    }

                    return Column(
                      children: [
                        Text(
                          title,
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
                              message,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TimerButtonWidget(
                          text: localithation.sendAgainButton,
                          onPressed: onPressed,
                        ),
                        const SizedBox(height: 22),
                        Container(
                          width: 278,
                          alignment: Alignment.center,
                          child: GoToLinkWidget(
                            text: localithation.returnToLoginLink,
                            onTap: () async {
                              await GetIt.I<FirebaseAuthManager>().logOut();
                              router.popForced();
                              router.navigate(const LoginRoute());
                            },
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
