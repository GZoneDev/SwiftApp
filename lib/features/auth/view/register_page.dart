import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:receptico/core/UI/theme.dart';
import 'package:receptico/core/router/router.dart';
import 'package:receptico/features/auth/bloc/auth/auth_localization.dart';
import 'package:receptico/generated/l10n.dart';

import '../bloc/bloc.dart';
import '../common/enum.dart';
import '../common/function/second_to_minute.dart';
import '../common/mixin.dart';
import '../widget/widget.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with ValidateMixin, ShowTimerDialogueMixin, RouteAware {
  final Map<EInput, TextEditingController> _controllers = {
    EInput.username: TextEditingController(),
    EInput.email: TextEditingController(),
    EInput.password: TextEditingController(),
  };

  bool _isUserOnCurrentPage = false;
  bool _isLockInput = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<AuthBloc>().add(AuthRoute());
    GetIt.I<RouteObserver<PageRoute>>()
        .subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void didPopNext() {
    context.read<AuthBloc>().add(AuthRoute());
    _clearForm();
  }

  void _clearForm() {
    if (_isLockInput) {
      context.read<TimerBloc>().add(RegisterTimerStop());
      setState(() => _isLockInput = false);
    }
    _controllers.forEach((key, controller) => controller.clear());
  }

  @override
  void dispose() {
    _controllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  void _sendEmail() {
    context.read<AuthBloc>().add(AuthSendRegisterEmail());
  }

  void _submit() {
    context.read<AuthBloc>().add(
          AuthRegister(
            username: _controllers[EInput.username]?.text ?? '',
            email: _controllers[EInput.email]?.text ?? '',
            password: _controllers[EInput.password]?.text ?? '',
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    final localization = S.of(context);
    final disableBorder =
        Theme.of(context).inputDecorationTheme.border?.copyWith(
              borderSide: Theme.of(context)
                  .inputDecorationTheme
                  .border
                  ?.borderSide
                  .copyWith(color: context.color.background.inputReadonly.safe),
            );
    final disableTextFieldDecoration = InputDecoration(
      filled: true,
      fillColor: context.color.background.inputReadonly.safe,
      contentPadding: Theme.of(context).inputDecorationTheme.contentPadding,
      enabledBorder: disableBorder,
      focusedBorder: disableBorder,
    );
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        _isUserOnCurrentPage = router.current.name == RegisterRoute.name;

        if (!_isUserOnCurrentPage) return;

        switch (state.runtimeType) {
          case const (AuthClearFail):
            _clearForm();
            break;

          case const (AuthSendRegisterPasswordEmail):
            context.read<TimerBloc>().add(RegisterTimerStart());
            popUpDialogWidget(context, localization.sendEmailMessage);
            break;

          case const (AuthRegisterSuccess):
            context.read<TimerBloc>().add(RegisterTimerStart());
            popUpDialogWidget(context, localization.sendEmailMessage);
            setState(() => _isLockInput = true);
            break;

          case const (AuthEmailVerifiedSuccess):
            router.navigate(const LoginRoute());
            _clearForm();
            break;
        }
      },
      child: ScaffoldWithGradientWidget(
        body: Stack(
          children: [
            const ScreenBackgroundWidget(IsMirrored: true),
            Container(
              alignment: Alignment.center,
              child: SizedBox(
                width: 278,
                height: 430,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TitleWidget(
                        title: localization.registerTitle,
                        subtitle: localization.registerSubtitle,
                      ),
                      const SizedBox(height: 13),
                      if (_isLockInput)
                        Column(
                          spacing: 16,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              controller: _controllers[EInput.username],
                              readOnly: true,
                              decoration: disableTextFieldDecoration,
                            ),
                            TextFormField(
                              controller: _controllers[EInput.email],
                              readOnly: true,
                              decoration: disableTextFieldDecoration,
                            ),
                            PasswordInputWidget(
                              controller: _controllers[EInput.password],
                              decoration: disableTextFieldDecoration,
                              margin: EdgeInsets.only(bottom: 8),
                              readOnly: true,
                            ),
                            BlocSelector<TimerBloc, TimerState, String?>(
                              selector: (state) => state is RegisterTimerUpdated
                                  ? secondToMinute(state.remainingSeconds)
                                  : null,
                              builder: (context, time) {
                                if (time == null) {
                                  return SizedBox(
                                    height: 40,
                                    child: TextButton(
                                      onPressed: _sendEmail,
                                      child: Text(
                                        localization.sendAgainButton,
                                      ),
                                    ),
                                  );
                                }

                                return Center(
                                  child: Text(
                                    time,
                                    style: context.font.title2Bold
                                        ?.copyWith(
                                            color:
                                                context.color.font.timer.safe)
                                        .safe,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      if (!_isLockInput)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SelectorTextInputWidget(
                              placeholder: localization.namePlaceholder,
                              controller: _controllers[EInput.username],
                              onChanged: usernameValidate,
                              selector: (state) =>
                                  _isUserOnCurrentPage && state is AuthFail
                                      ? AuthLocalizationHelper.localizate(
                                          //state.errors[EBlocError.username],
                                          state.username,
                                          localization,
                                        )
                                      : null,
                            ),
                            SelectorTextInputWidget(
                              placeholder: localization.emailPlaceholder,
                              controller: _controllers[EInput.email],
                              onChanged: emailValidate,
                              selector: (state) =>
                                  _isUserOnCurrentPage && state is AuthFail
                                      ? AuthLocalizationHelper.localizate(
                                          //state.errors[EBlocError.email],
                                          state.email,
                                          localization,
                                        )
                                      : null,
                            ),
                            SelectorPasswordInputWidget(
                              placeholder: localization.passwordPlaceholder,
                              controller: _controllers[EInput.password],
                              onChanged: passwordValidate,
                              selector: (state) =>
                                  _isUserOnCurrentPage && state is AuthFail
                                      ? AuthLocalizationHelper.localizate(
                                          //state.errors[EBlocError.password],
                                          state.password,
                                          localization,
                                        )
                                      : null,
                            ),
                            SizedBox(
                              height: 40,
                              child: TextButton(
                                onPressed: _submit,
                                child: Text(localization.registerButton),
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 16),
                      FooterWidget(
                        text: localization.accountQuestion,
                        linkText: localization.loginLink,
                        onTab: () {
                          router.navigate(const LoginRoute());
                          _clearForm();
                        },
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
