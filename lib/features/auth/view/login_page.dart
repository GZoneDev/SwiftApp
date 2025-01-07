import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptico/core/router/router.dart';
import 'package:receptico/generated/l10n.dart';
import 'package:receptico/core/UI/theme.dart';

import '../bloc/bloc.dart';
import '../common/enum_input.dart';
import '../widget/widget.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Map<EInput, TextEditingController> _controllers = {
    EInput.emailOrPhone: TextEditingController(),
    EInput.password: TextEditingController(),
  };

  @override
  void dispose() {
    _controllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  void _clearForm() =>
      _controllers.forEach((key, controller) => controller.clear());

  String? _emailOrPhoneValidate(String? value) {
    context.read<AuthBloc>().add(
          AuthEmailValidateEvent(
            value: value,
            localization: S.of(context),
          ),
        );
    return value;
  }

  String? _passwordValidate(String? value) {
    context.read<AuthBloc>().add(
          AuthPasswordValidateEvent(
            value: value,
            localization: S.of(context),
          ),
        );
    return value;
  }

  void _submit() {
    _emailOrPhoneValidate(_controllers[EInput.emailOrPhone]?.text);
    _passwordValidate(_controllers[EInput.password]?.text);

    context.read<AuthBloc>().add(
          AuthLoginEvent(
            emailOrPhone: _controllers[EInput.emailOrPhone]?.text ?? '',
            password: _controllers[EInput.password]?.text ?? '',
            localization: S.of(context),
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
            _clearForm();
            // TODO: Update routing to the profile page
            router.navigateNamed('/temp');
            break;
        }
      },
      child: ScaffoldWithGradientWidget(
        child: Stack(
          children: [
            const ScreenBackgroundWidget(),
            Container(
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
                      SelectorTextInputWidget(
                        placeholder: localization.emailPlaceholder,
                        selector: (state) => state.errors?[EBlocError.email],
                        controller: _controllers[EInput.emailOrPhone],
                        onChanged: _emailOrPhoneValidate,
                      ),
                      SelectorPasswordInputWidget(
                        placeholder: localization.passwordPlaceholder,
                        selector: (state) => state.errors?[EBlocError.password],
                        controller: _controllers[EInput.password],
                        onChanged: _passwordValidate,
                        margin: EdgeInsets.only(bottom: 22.0),
                        helpWidget: LinkWidget(
                          text: localization.forgottenPassword,
                          onTap: () {
                            router.navigate(const RestorePasswordRoute());
                            context.read<AuthBloc>().add(AuthRouteEvent());
                          },
                        ),
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
                        onTab: () {
                          router.navigate(const RegisterRoute());
                          context.read<AuthBloc>().add(AuthRouteEvent());
                        },
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 8,
                        children: [
                          IconButtonWidget(
                            assetPath: context.assetPath.appleLogo,
                            onPressed: () {
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

class ScaffoldWithGradientWidget extends StatelessWidget {
  final Widget child;
  const ScaffoldWithGradientWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<AuthBloc>().add(AuthRouteEvent());
        return true;
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFFC60F),
                Color(0xFFFF9F0A),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
