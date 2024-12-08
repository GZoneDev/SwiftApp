import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptico/core/asset/asset_path.dart';
import 'package:receptico/core/router/router.dart';

import '../block/block.dart';
import '../model/user.dart';
import '../widget/widget.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late bool _isError;
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
      context.read<AuthBloc>().add(AuthFailClear());
    }
  }

  void _submit() {
    context.read<AuthBloc>().add(
          AuthLogin(
            user: LoginUser(
              email: _emailController.text,
              password: _passwordController.text,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LoginScreenBackgroundWidget(),
          Container(
            alignment: Alignment.center,
            child: SizedBox(
              width: 278,
              height: 448,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const TitleWidget(
                      title: 'Вхід',
                      subtitle: 'Увійдіть до облікового запису',
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                      if (state is AuthLoginFailure &&
                          state.emailError != null) {
                        _isError = true;
                        return ErrorMessageWidget(
                            errorMessage: state.emailError!);
                      }
                      return SizedBox(height: 16);
                    }),
                    TextInputWidget(
                      controller: _emailController,
                      placeholder: 'Email',
                      onTap: _clearFailMessage,
                    ),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthLoginFailure &&
                            state.passwordError != null) {
                          _isError = true;
                          return ErrorMessageWidget(
                              errorMessage: state.passwordError!);
                        }
                        return SizedBox(height: 16);
                      },
                    ),
                    PasswordInputWidget(
                      controller: _passwordController,
                      placeholder: 'Пароль',
                      onTap: _clearFailMessage,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          debugPrint('Not created!');
                        },
                        child: const Text(
                          'Забули пароль?',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    LinkButtonWidget(
                      text: 'Увійти',
                      onPressed: _submit,
                    ),
                    const SizedBox(height: 16),
                    FooterWidget(
                      text: 'Не маєте акаунту?',
                      linkText: 'Створити зараз',
                      onTab: () =>
                          AutoRouter.of(context).push(RegistrationRoute()),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButtonWidget(
                          assetPath: AssetPath.appleLogoPath,
                          onPressed: () {
                            debugPrint('Not created!');
                          },
                        ),
                        const SizedBox(width: 8),
                        IconButtonWidget(
                          assetPath: AssetPath.googleLogoPath,
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
        ],
      ),
    );
  }
}

class LoginScreenBackgroundWidget extends StatelessWidget {
  const LoginScreenBackgroundWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const Positioned(
          top: -95,
          left: -73,
          child: CircleWidget(width: 254, height: 254),
        ),
        const Positioned(
          bottom: -34,
          left: -47,
          child: CircleWidget(width: 123, height: 123),
        ),
        const Positioned(
          bottom: -72,
          right: -41,
          child: CircleWidget(width: 196, height: 196),
        ),
      ],
    );
  }
}
