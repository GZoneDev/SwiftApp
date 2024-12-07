import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptico/core/asset/asset_path.dart';
import 'package:receptico/core/router/router.dart';

import '../block/block.dart';
import '../widgets/widget.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
          Container(
            alignment: Alignment.center,
            child: SizedBox(
              width: 278,
              height: 438,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'Вхід',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Увійдіть до облікового запису',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 32),
                    const TextInputWidget(placeholder: 'Email'),
                    const SizedBox(height: 16),
                    PasswordInputWidget(placeholder: 'Пароль'),
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
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    BlocListener<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthSuccess) {
                          AutoRouter.of(context).push(StartRoute());
                        }
                      },
                      child: Container(),
                    ),
                    LinkButtonWidget(
                      text: 'Увійти',
                      onPressed: () {
                        context.read<AuthBloc>().add(
                            AuthLogin(email: 'email', password: 'password'));
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Не маєте акаунту?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () {
                            AutoRouter.of(context).push(RegistrationRoute());
                          },
                          child: const Text(
                            'Створити зараз',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
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
