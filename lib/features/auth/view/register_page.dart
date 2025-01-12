import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptico/core/router/router.dart';
import 'package:receptico/generated/l10n.dart';

import '../bloc/auth_bloc.dart';
import '../common/enum.dart';
import '../common/mixin.dart';
import '../widget/widget.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with ValidateMixin, ShowTimerDialogueMixin {
  final Map<EInput, TextEditingController> _controllers = {
    EInput.username: TextEditingController(),
    EInput.email: TextEditingController(),
    EInput.password: TextEditingController(),
  };

  void _clearForm() =>
      _controllers.forEach((key, controller) => controller.clear());

  @override
  void dispose() {
    _controllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  void _submit() {
    usernameValidate(_controllers[EInput.username]?.text);
    emailValidate(_controllers[EInput.email]?.text);
    passwordValidate(_controllers[EInput.password]?.text);

    context.read<AuthBloc>().add(
          AuthRegisterEvent(
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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case const (AuthClearFailState):
            _clearForm();
            break;

          case const (AuthRegisterSuccessState):
            router.navigate(const SendEmailRoute());
            break;

          case const (AuthShowWaitMessageState):
            showTimedDialog(context);
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TitleWidget(
                        title: localization.registerTitle,
                        subtitle: localization.registerSubtitle,
                      ),
                      const SizedBox(height: 13),
                      SelectorTextInputWidget(
                        placeholder: localization.namePlaceholder,
                        controller: _controllers[EInput.username],
                        errorType: EBlocError.username,
                        routerPageName: RegisterRoute.name,
                        onChanged: usernameValidate,
                      ),
                      SelectorTextInputWidget(
                        placeholder: localization.emailPlaceholder,
                        controller: _controllers[EInput.email],
                        errorType: EBlocError.email,
                        routerPageName: RegisterRoute.name,
                        onChanged: emailValidate,
                      ),
                      SelectorPasswordInputWidget(
                        placeholder: localization.passwordPlaceholder,
                        controller: _controllers[EInput.password],
                        errorType: EBlocError.password,
                        routerPageName: RegisterRoute.name,
                        onChanged: passwordValidate,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextButton(
                          onPressed: _submit,
                          child: Text(localization.registerButton),
                        ),
                      ),
                      const SizedBox(height: 16),
                      FooterWidget(
                        text: localization.accountQuestion,
                        linkText: localization.loginLink,
                        onTab: () => router.navigate(const LoginRoute()),
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
