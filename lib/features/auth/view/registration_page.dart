import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptico/core/router/router.dart';

import '../block/auth_block.dart';
import '../model/user.dart';
import '../widget/widget.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late bool _isError;
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isError = false;
  }

  void _clearFailureMessage() {
    if (_isError) {
      _isError = false;
      context.read<AuthBloc>().add(AuthFailClear());
    }
  }

  void _submit() {
    context.read<AuthBloc>().add(
          AuthRegister(
            user: RegisterUser(
              email: _emailController.text,
              username: _usernameController.text,
              phone: _phoneController.text,
              password: _passwordController.text,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthRegisterSuccess) {
          AutoRouter.of(context).push(StartRoute());
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            RegisterScreenWidget(),
            Container(
              alignment: Alignment.center,
              child: SizedBox(
                width: 278,
                height: 435,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const TitleWidget(
                        title: 'Реєстрація',
                        subtitle: 'Створіть новий акаунт',
                      ),
                      SizedBox(height: 16),
                      BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                        if (state is AuthRegisterFailure &&
                            state.usernameError != null) {
                          _isError = true;
                          return ErrorMessageWidget(
                              errorMessage: state.usernameError!);
                        }
                        return SizedBox(height: 16);
                      }),
                      TextInputWidget(
                        placeholder: 'Ім’я',
                        controller: _usernameController,
                        onTap: _clearFailureMessage,
                      ),
                      BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                        if (state is AuthRegisterFailure &&
                            state.emailError != null) {
                          _isError = true;
                          return ErrorMessageWidget(
                              errorMessage: state.emailError!);
                        }
                        return SizedBox(height: 16);
                      }),
                      TextInputWidget(
                        placeholder: 'Email',
                        controller: _emailController,
                        onTap: _clearFailureMessage,
                      ),
                      BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                        if (state is AuthRegisterFailure &&
                            state.phoneError != null) {
                          _isError = true;
                          return ErrorMessageWidget(
                              errorMessage: state.phoneError!);
                        }
                        return SizedBox(height: 16);
                      }),
                      TextInputWidget(
                        placeholder: 'Номер телефону',
                        controller: _phoneController,
                        onTap: _clearFailureMessage,
                      ),
                      BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                        if (state is AuthRegisterFailure &&
                            state.passwordError != null) {
                          _isError = true;
                          return ErrorMessageWidget(
                              errorMessage: state.passwordError!);
                        }
                        return SizedBox(height: 16);
                      }),
                      PasswordInputWidget(
                        placeholder: 'Пароль',
                        controller: _passwordController,
                        onTap: _clearFailureMessage,
                      ),
                      SizedBox(height: 28),
                      LinkButtonWidget(
                        text: 'Створити',
                        onPressed: _submit,
                      ),
                      SizedBox(height: 16),
                      FooterWidget(
                        text: 'Вже маєте акаунт?',
                        linkText: 'Увійти',
                        onTab: () =>
                            AutoRouter.of(context).push(AuthorizationRoute()),
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

class RegisterScreenWidget extends StatelessWidget {
  const RegisterScreenWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const Positioned(
          top: -95,
          right: -76,
          child: CircleWidget(width: 254, height: 254),
        ),
        const Positioned(
          bottom: -34,
          right: -37,
          child: CircleWidget(width: 123, height: 123),
        ),
        const Positioned(
          bottom: -71,
          left: -33,
          child: CircleWidget(width: 196, height: 196),
        ),
      ],
    );
  }
}
