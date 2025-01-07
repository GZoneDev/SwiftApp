import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptico/core/router/router.dart';
import 'package:receptico/generated/l10n.dart';

import '../bloc/auth_bloc.dart';
import '../common/enum.dart';
import '../widget/widget.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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

  String? _usernameValidate(String? value) {
    context.read<AuthBloc>().add(
          AuthUsernameValidateEvent(
            value: value,
            localization: S.of(context),
          ),
        );
    return value;
  }

  String? _emailOrPhoneValidate(String? value) {
    context.read<AuthBloc>().add(
          AuthEmailOrPhoneValidateEvent(
            value: value,
            localization: S.of(context),
          ),
        );
    return value;
  }

  String? _passwordValidate(String? value) {
    context.read<AuthBloc>().add(
          AuthPasswordValidateEvent(
            value: value,
            localization: S.of(context),
          ),
        );
    return value;
  }

  void _submit() {
    _usernameValidate(_controllers[EInput.username]?.text);
    _emailOrPhoneValidate(_controllers[EInput.emailOrPhone]?.text);
    _passwordValidate(_controllers[EInput.password]?.text);

    context.read<AuthBloc>().add(
          AuthRegisterEvent(
            username: _controllers[EInput.username]?.text ?? '',
            emailOrPhone: _controllers[EInput.emailOrPhone]?.text ?? '',
            password: _controllers[EInput.password]?.text ?? '',
            localization: S.of(context),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    final localization = S.of(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthClearFailState) _clearForm();

        if (state is AuthRegisterSuccessState) {
          router.navigate(const SendEmailRoute());
          _clearForm();
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          context.read<AuthBloc>().add(AuthRouteEvent());
          return true;
        },
        child: Scaffold(
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
                          selector: (state) =>
                              state.errors?[EBlocError.username],
                          onChanged: _usernameValidate,
                        ),
                        SelectorTextInputWidget(
                          placeholder: localization.emailOrPhonePlaceholder,
                          controller: _controllers[EInput.emailOrPhone],
                          selector: (state) =>
                              state.errors?[EBlocError.emailOrPhone],
                          onChanged: _emailOrPhoneValidate,
                        ),
                        SelectorPasswordInputWidget(
                          placeholder: localization.passwordPlaceholder,
                          controller: _controllers[EInput.password],
                          selector: (state) =>
                              state.errors?[EBlocError.password],
                          onChanged: _passwordValidate,
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
      ),
    );
  }
}
