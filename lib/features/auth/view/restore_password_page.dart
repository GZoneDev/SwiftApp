import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptico/core/UI/theme.dart';
import 'package:receptico/core/router/router.dart';
import 'package:receptico/features/auth/bloc/auth/auth_localization.dart';
import 'package:receptico/features/auth/common/function/second_to_minute.dart';
import 'package:receptico/generated/l10n.dart';

import '../bloc/bloc.dart';
import '../common/mixin.dart';
import '../widget/widget.dart';

@RoutePage()
class RestorePasswordPage extends StatefulWidget {
  const RestorePasswordPage({super.key});

  @override
  State<RestorePasswordPage> createState() => _RestorePasswordPageState();
}

class _RestorePasswordPageState extends State<RestorePasswordPage>
    with ShowTimerDialogueMixin, ValidateMixin {
  final _emailController = TextEditingController();

  bool _isUserOnCurrentPage = false;

  @override
  void initState() {
    BlocProvider.of<AuthBloc>(context).add(AuthRoute());
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _clearForm() => _emailController.clear();

  void _submit() {
    BlocProvider.of<AuthBloc>(context)
        .add(AuthRestore(email: _emailController.text));
  }

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    final localization = S.of(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        _isUserOnCurrentPage = router.current.name == RestorePasswordRoute.name;

        if (!_isUserOnCurrentPage) return;

        switch (state.runtimeType) {
          case const (AuthClearFail):
            _clearForm();
            break;

          case const (AuthSendRestorePasswordEmail):
            popUpDialogWidget(context, localization.sendEmailMessage);
            BlocProvider.of<TimerBloc>(context).add(RestoreTimerStart());
            break;
        }
      },
      child: ScaffoldWithGradientWidget(
        body: Stack(
          children: [
            const ScreenBackgroundWidget(),
            Container(
              alignment: Alignment.center,
              child: SizedBox(
                width: 350,
                height: 325,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TitleWidget(
                        title: localization.restorePasswordTitle,
                        subtitle: localization.restorePasswordSubtitle,
                      ),
                      const SizedBox(height: 37),
                      SizedBox(
                        width: 278,
                        child: Column(
                          children: [
                            SelectorTextInputWidget(
                              placeholder: localization.emailPlaceholder,
                              controller: _emailController,
                              onChanged: emailValidate,
                              margin: EdgeInsets.only(bottom: 22.0),
                              marginWithError: EdgeInsets.only(bottom: 16.0),
                              selector: (state) =>
                                  _isUserOnCurrentPage && state is AuthFail
                                      ? AuthLocalizationHelper.localizate(
                                          state.email,
                                          localization,
                                        )
                                      : null,
                            ),
                            BlocSelector<TimerBloc, TimerState, String?>(
                              selector: (state) => state is RestoreTimerUpdated
                                  ? secondToMinute(state.remainingSeconds)
                                  : null,
                              builder: (context, time) {
                                if (time == null) {
                                  return SizedBox(
                                    height: 40,
                                    width: 278,
                                    child: TextButton(
                                      onPressed: _submit,
                                      child: Text(
                                          localization.restorePasswordButton),
                                    ),
                                  );
                                }

                                return Text(
                                  time,
                                  style: context.font.title2Bold
                                      ?.copyWith(
                                          color: context.color.font.timer.safe)
                                      .safe,
                                );
                              },
                            ),
                            const SizedBox(height: 22),
                            GoToLinkWidget(
                              text: localization.returnToLoginLink,
                              onTap: () => router.navigate(const LoginRoute()),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            LoadingWidget(),
          ],
        ),
      ),
    );
  }
}
