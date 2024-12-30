import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptico/core/router/router.dart';
import 'package:receptico/generated/l10n.dart';

import '../bloc/bloc.dart';
import '../widget/widget.dart';

@RoutePage()
class RestorePasswordPage extends StatefulWidget {
  const RestorePasswordPage({super.key});

  @override
  State<RestorePasswordPage> createState() => _RestorePasswordPageState();
}

class _RestorePasswordPageState extends State<RestorePasswordPage> {
  late bool _isError;
  AuthLoginFailState _authState = AuthLoginFailState();
  final _emailOrPhoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isError = false;
  }

  void _clearFailMessage() {
    if (_isError) {
      _isError = false;
      //setState(() => _authState = AuthLoginFailure());
    }
  }

  void _submit() {
    // context.read<AuthBloc>().add(
    //       AuthLogin(
    //         user: LoginUser(
    //           email: _emailController.text,
    //         ),
    //       ),
    //     );
  }

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    final localization = S.of(context);
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoginFailState) {
            _isError = true;
            setState(() => _authState = state);
          }
        },
        child: Stack(
          children: [
            const ScreenBackgroundWidget(),
            Container(
              alignment: Alignment.center,
              child: SizedBox(
                width: 350,
                height: 458,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TitleWidget(
                        title: localization.restorePasswordTitle,
                        subtitle: localization.restorePasswordSubtitle,
                      ),
                      const SizedBox(height: 37),
                      SizedBox(
                        width: 278,
                        child: Column(
                          children: [
                            TextInputWidget(
                              controller: _emailOrPhoneController,
                              placeholder: localization.emailOrPhonePlaceholder,
                              onTap: _clearFailMessage,
                              errorMessage: _authState.emailOrPhoneError,
                              margin: EdgeInsets.only(bottom: 19.0),
                              marginWithError: EdgeInsets.only(bottom: 16.0),
                            ),
                            TextButtonWidget(
                              height: 50,
                              text: localization.restorePasswordButton,
                              onPressed: () => router.navigate(
                                  const RestorePhoneRoute()), //_submit,
                            ),
                            const SizedBox(height: 22),
                            BackLinkWidget(
                              text: localization.returnToLoginLink,
                              onTap: () => router.navigate(const LoginRoute()),
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
      ),
    );
  }
}
