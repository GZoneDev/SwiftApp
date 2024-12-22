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
  AuthRegisterFailure _authState = AuthRegisterFailure();
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isError = false;
  }

  void _clearFailMessage() {
    if (_isError) {
      _isError = false;
      setState(() => _authState = AuthRegisterFailure());
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
    const marginTextInput = EdgeInsets.only(bottom: 10.0),
        marginTextInputWithError = EdgeInsets.only(bottom: 7.0);
    var router = AutoRouter.of(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthRegisterSuccess) {
          router.goTo(StartRoute());
        }
        if (state is AuthRegisterFailure) {
          _isError = true;
          setState(() => _authState = state);
          return;
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
                height: 520,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const TitleWidget(
                        title: 'Реєстрація',
                        subtitle: 'Створіть новий акаунт',
                      ),
                      const SizedBox(height: 13),
                      TextInputWidget(
                        placeholder: 'Ім’я',
                        controller: _usernameController,
                        onTap: _clearFailMessage,
                        errorMessage: _authState.usernameError,
                        margin: marginTextInput,
                        marginWithError: marginTextInputWithError,
                      ),
                      TextInputWidget(
                        placeholder: 'Email',
                        controller: _emailController,
                        onTap: _clearFailMessage,
                        errorMessage: _authState.emailError,
                        margin: marginTextInput,
                        marginWithError: marginTextInputWithError,
                      ),
                      TextInputWidget(
                        placeholder: 'Номер телефону',
                        controller: _phoneController,
                        onTap: _clearFailMessage,
                        errorMessage: _authState.phoneError,
                        margin: marginTextInput,
                        marginWithError: marginTextInputWithError,
                      ),
                      PasswordInputWidget(
                        controller: _passwordController,
                        placeholderText: 'Пароль',
                        onTap: _clearFailMessage,
                        errorMessage: _authState.passwordError,
                        margin: const EdgeInsets.only(bottom: 25.0),
                        marginWithError: const EdgeInsets.only(bottom: 22.0),
                      ),
                      LinkButtonWidget(
                        text: 'Створити',
                        onPressed: _submit,
                      ),
                      const SizedBox(height: 16),
                      FooterWidget(
                        text: 'Вже маєте акаунт?',
                        linkText: 'Увійти',
                        onTab: () {
                          router.goTo(LoginRoute());
                          _clearFailMessage();
                        },
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
