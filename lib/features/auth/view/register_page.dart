import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptico/core/router/router.dart';
import 'package:receptico/generated/l10n.dart';

import '../bloc/auth_bloc.dart';
import '../widget/widget.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late bool _isError;
  AuthRegisterFailState _authState = AuthRegisterFailState();
  final _usernameController = TextEditingController();
  final _emailOrPhoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isError = false;
  }

  void _clearFailMessage() {
    if (_isError) {
      _isError = false;
      setState(() => _authState = AuthRegisterFailState());
    }
  }

  void _submit() {
    context.read<AuthBloc>().add(
          AuthRegisterEvent(
            username: _usernameController.text,
            emailOrPhone: _passwordController.text,
            password: _passwordController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    const marginTextInput = EdgeInsets.only(bottom: 16.0),
        marginTextInputWithError = EdgeInsets.only(bottom: 10.0);
    final router = AutoRouter.of(context);
    final localization = S.of(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthRegisterSuccessState) {
          router.navigate(const StartRoute());
        }
        if (state is AuthRegisterFailState) {
          _isError = true;
          setState(() => _authState = state);
          return;
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            const ScreenBackgroundWidget(IsMirrored: true),
            Container(
              alignment: Alignment.center,
              child: SizedBox(
                width: 278,
                height: 400,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TitleWidget(
                        title: localization.registerTitle,
                        subtitle: localization.registerSubtitle,
                      ),
                      const SizedBox(height: 13),
                      TextInputWidget(
                        placeholder: localization.namePlaceholder,
                        controller: _usernameController,
                        onTap: _clearFailMessage,
                        errorMessage: _authState.usernameError,
                        margin: marginTextInput,
                        marginWithError: marginTextInputWithError,
                      ),
                      TextInputWidget(
                        placeholder: localization.emailOrPhonePlaceholder,
                        controller: _emailOrPhoneController,
                        onTap: _clearFailMessage,
                        errorMessage: _authState.emailOrPhoneError,
                        margin: marginTextInput,
                        marginWithError: marginTextInputWithError,
                      ),
                      PasswordInputWidget(
                        controller: _passwordController,
                        placeholderText: localization.passwordPlaceholder,
                        onTap: _clearFailMessage,
                        errorMessage: _authState.passwordError,
                        margin: const EdgeInsets.only(bottom: 25.0),
                        marginWithError: const EdgeInsets.only(bottom: 22.0),
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
                        onTab: () => router.navigate(const LoginRoute()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
