import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptico/core/router/router.dart';
import 'package:receptico/generated/l10n.dart';
import 'package:receptico/core/UI/theme.dart';

import '../bloc/bloc.dart';
import '../common/enum/enum_input.dart';
import '../common/mixin.dart';
import '../widget/widget.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ValidateMixin {
  final Map<EInput, TextEditingController> _controllers = {
    EInput.email: TextEditingController(),
    EInput.password: TextEditingController(),
  };

  @override
  void dispose() {
    _controllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  void _clearForm() =>
      _controllers.forEach((key, controller) => controller.clear());

  void _submit() {
    emailValidate(_controllers[EInput.email]?.text);
    passwordValidate(_controllers[EInput.password]?.text);

    context.read<AuthBloc>().add(
          AuthLoginEvent(
            email: _controllers[EInput.email]?.text ?? '',
            password: _controllers[EInput.password]?.text ?? '',
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    final localization = S.of(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case const (AuthClearFailState):
            _clearForm();
            break;

          case const (AuthLoginSuccessState):
            // TODO: Update routing to the profile page
            router.navigateNamed('/');
            break;
        }
      },
      child: ScaffoldWithGradientWidget(
        body: Stack(
          children: [
            const ScreenBackgroundWidget(),
            Container(
              alignment: Alignment.center,
              child: SizedBox(
                width: 278,
                height: 458,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TitleWidget(
                        title: localization.loginTitle,
                        subtitle: localization.loginSubtitle,
                      ),
                      const SizedBox(height: 16),
                      SelectorTextInputWidget(
                        placeholder: localization.emailPlaceholder,
                        errorType: EBlocError.email,
                        routerPageName: LoginRoute.name,
                        controller: _controllers[EInput.email],
                        onChanged: emailValidate,
                      ),
                      SelectorPasswordInputWidget(
                        placeholder: localization.passwordPlaceholder,
                        errorType: EBlocError.password,
                        routerPageName: LoginRoute.name,
                        controller: _controllers[EInput.password],
                        onChanged: passwordValidate,
                        margin: EdgeInsets.only(bottom: 22.0),
                        helpWidget: Container(
                          margin: EdgeInsets.only(right: 8),
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () =>
                                router.navigate(const RestorePasswordRoute()),
                            child: Text(
                              localization.forgottenPassword,
                              style: context.font.caption1,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: TextButton(
                          onPressed: _submit,
                          child: Text(localization.loginButton),
                        ),
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
                        spacing: 8,
                        children: [
                          if (Platform.isIOS)
                            IconButtonWidget(
                              assetPath: context.assetPath.appleLogo,
                              onPressed: () {
                                // TODO: need create apple sign in
                                debugPrint('Not created!');
                              },
                            ),
                          IconButtonWidget(
                            assetPath: context.assetPath.googleLogo,
                            onPressed: () {
                              context
                                  .read<AuthBloc>()
                                  .add(AuthGoogleSingInEvent());
                            },
                          ),
                        ],
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
    );
  }
}
