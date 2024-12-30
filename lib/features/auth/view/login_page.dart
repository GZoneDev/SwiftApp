import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptico/core/router/router.dart';
import 'package:receptico/generated/l10n.dart';
import 'package:receptico/core/UI/theme.dart';

import '../bloc/bloc.dart';
import '../widget/widget.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late bool _isError;
  AuthLoginFailState _authState = AuthLoginFailState();
  final _emailOrPhoneController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _isError = false;
  }

  void _clearFailMessage() {
    if (_isError) {
      _isError = false;
      setState(() => _authState = AuthLoginFailState());
    }
  }

  void _submit() {
    _formKey.currentState!.validate();
    context.read<AuthBloc>().add(
          AuthLoginEvent(
            emailOrPhone: _passwordController.text,
            password: _passwordController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    final localization = S.of(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoginFailState) {
          _isError = true;
          setState(() => _authState = state);
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            const ScreenBackgroundWidget(),
            Form(
              key: _formKey,
              child: Container(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 278,
                  height: 458,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TitleWidget(
                          title: localization.loginTitle,
                          subtitle: localization.loginSubtitle,
                        ),
                        const SizedBox(height: 16),
                        TextInputWidget(
                          controller: _emailOrPhoneController,
                          placeholder: localization.emailOrPhonePlaceholder,
                          onTap: _clearFailMessage,
                          errorMessage: _authState.emailOrPhoneError,
                          margin: EdgeInsets.only(bottom: 16.0),
                          marginWithError: EdgeInsets.only(bottom: 10.0),
                        ),
                        PasswordInputWidget(
                          controller: _passwordController,
                          placeholderText: localization.passwordPlaceholder,
                          onTap: _clearFailMessage,
                          errorMessage: _authState.passwordError,
                          helpWidget: LinkWidget(
                            text: localization.forgottenPassword,
                            onTap: () =>
                                router.navigate(const RestorePasswordRoute()),
                          ),
                          margin: EdgeInsets.only(bottom: 22.0),
                          marginWithError: EdgeInsets.only(bottom: 22.0),
                        ),
                        TextButtonWidget(
                          height: 50,
                          text: localization.loginButton,
                          onPressed: _submit,
                        ),
                        const SizedBox(height: 16),
                        FooterWidget(
                          text: localization.noAccountQuestion,
                          linkText: localization.createAccount,
                          onTab: () => router.navigate(const RegisterRoute()),
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButtonWidget(
                              assetPath: context.assetPath.appleLogo,
                              onPressed: () {
                                debugPrint('Not created!');
                              },
                            ),
                            const SizedBox(width: 8),
                            IconButtonWidget(
                              assetPath: context.assetPath.googleLogo,
                              onPressed: () {
                                debugPrint('Not created!');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
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
