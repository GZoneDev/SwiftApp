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
    EInput.emailOrPhone: TextEditingController(),
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
    emailValidate(_controllers[EInput.emailOrPhone]?.text);
    passwordValidate(_controllers[EInput.password]?.text);

    context.read<AuthBloc>().add(
          AuthRegisterEvent(
            username: _controllers[EInput.username]?.text ?? '',
            email: _controllers[EInput.emailOrPhone]?.text ?? '',
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
            _clearForm();
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
                    children: [
                      TitleWidget(
                        title: localization.registerTitle,
                        subtitle: localization.registerSubtitle,
                      ),
                      const SizedBox(height: 13),
                      SelectorTextInputWidget(
                        placeholder: localization.namePlaceholder,
                        controller: _controllers[EInput.username],
                        selector: (state) => state.errors?[EBlocError.username],
                        onChanged: usernameValidate,
                      ),
                      SelectorTextInputWidget(
                        placeholder: localization.emailPlaceholder,
                        controller: _controllers[EInput.emailOrPhone],
                        selector: (state) => state.errors?[EBlocError.email],
                        onChanged: emailValidate,
                      ),
                      SelectorPasswordInputWidget(
                        placeholder: localization.passwordPlaceholder,
                        controller: _controllers[EInput.password],
                        selector: (state) => state.errors?[EBlocError.password],
                        onChanged: passwordValidate,
                      ),
                      TextButtonWidget(
                        height: 50,
                        text: localization.registerButton,
                        onPressed: _submit,
                      ),
                      const SizedBox(height: 16),
                      FooterWidget(
                        text: localization.accountQuestion,
                        linkText: localization.loginLink,
                        onTab: () {
                          context.read<AuthBloc>().add(AuthRouteEvent());
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
