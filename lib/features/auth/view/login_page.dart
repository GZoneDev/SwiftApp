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
  AuthLoginFailure _authState = AuthLoginFailure();
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
      setState(() => _authState = AuthLoginFailure());
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
    var router = AutoRouter.of(context);
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoginFailure) {
            _isError = true;
            setState(() => _authState = state);
            return;
          }
        },
        child: Stack(
          children: [
            LoginScreenBackgroundWidget(),
            Container(
              alignment: Alignment.center,
              child: SizedBox(
                width: 278,
                height: 458,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const TitleWidget(
                        title: 'Вхід',
                        subtitle: 'Увійдіть до облікового запису',
                      ),
                      const SizedBox(height: 16),
                      TextInputWidget(
                        controller: _emailController,
                        placeholder: 'Email',
                        onTap: _clearFailMessage,
                        errorMessage: _authState.emailError,
                        margin: EdgeInsets.only(bottom: 10.0),
                        marginWithError: EdgeInsets.only(bottom: 7.0),
                      ),
                      PasswordInputWidget(
                        controller: _passwordController,
                        placeholderText: 'Пароль',
                        onTap: _clearFailMessage,
                        errorMessage: _authState.passwordError,
                        helpWidget: LinkWidget(text: 'Забули пароль?'),
                        margin: EdgeInsets.only(bottom: 25.0),
                        marginWithError: EdgeInsets.only(bottom: 22.0),
                      ),
                      LinkButtonWidget(
                        text: 'Увійти',
                        onPressed: _submit,
                      ),
                      const SizedBox(height: 16),
                      FooterWidget(
                        text: 'Не маєте акаунту?',
                        linkText: 'Створити зараз',
                        onTab: () {
                          router.goTo(RegisterRoute());
                          _clearFailMessage();
                        },
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
