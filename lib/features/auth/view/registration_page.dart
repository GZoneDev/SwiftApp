import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptico/core/router/router.dart';

import '../block/auth_block.dart';
import '../widgets/widget.dart';

@RoutePage()
class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(),
      child: RegistrationScreenWidget(),
    );
  }
}

class RegistrationScreenWidget extends StatelessWidget {
  const RegistrationScreenWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
          Container(
            alignment: Alignment.center,
            child: SizedBox(
              width: 278,
              height: 435,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'Реєстрація',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    const Text(
                      'Створіть новий акаунт',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 32),
                    const TextInputWidget(placeholder: 'Ім’я'),
                    SizedBox(height: 16),
                    const TextInputWidget(placeholder: 'Email'),
                    SizedBox(height: 16),
                    const TextInputWidget(placeholder: 'Номер телефону'),
                    SizedBox(height: 16),
                    PasswordInputWidget(placeholder: 'Пароль'),
                    SizedBox(height: 28),
                    LinkButtonWidget(
                      text: 'Створити',
                      onPressed: () {
                        context.read<AuthBloc>().add(
                            AuthLogin(email: 'email', password: 'password'));
                      },
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Вже маєте акаунт?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 8),
                          InkWell(
                            onTap: () {
                              AutoRouter.of(context).push(AuthorizationRoute());
                            },
                            child: Text(
                              'Увійти',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
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
