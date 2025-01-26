import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:receptico/core/router/router.dart';
import 'package:receptico/features/auth/bloc/auth/auth_localization.dart';
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

class _LoginPageState extends State<LoginPage>
    with ValidateMixin, ShowTimerDialogueMixin, RouteAware {
  final Map<EInput, TextEditingController> _controllers = {
    EInput.email: TextEditingController(),
    EInput.password: TextEditingController(),
  };

  bool _isUserOnCurrentPage = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<AuthBloc>().add(AuthRoute());
    GetIt.I<RouteObserver<PageRoute>>()
        .subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void didPopNext() {
    context.read<AuthBloc>().add(AuthRoute());
    _clearForm();
  }

  @override
  void initState() {
    context.read<AuthBloc>().add(AuthRoute());
    super.initState();
  }

  @override
  void dispose() {
    GetIt.I<RouteObserver<PageRoute>>().unsubscribe(this);
    _controllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  void _clearForm() {
    _controllers.forEach((key, controller) => controller.clear());
    context.read<AuthBloc>().add(AuthRoute());
  }

  void _submit() {
    context.read<AuthBloc>().add(
          AuthLogin(
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
        _isUserOnCurrentPage = router.current.name == LoginRoute.name;

        if (!_isUserOnCurrentPage) return;

        switch (state.runtimeType) {
          case const (AuthLoginSuccess):
            // TODO: Update routing to the profile page
            _clearForm();
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
              child: SingleChildScrollView(
                child: SizedBox(
                  width: 278,
                  height: 458,
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
                        controller: _controllers[EInput.email],
                        onChanged: emailValidate,
                        selector: (state) =>
                            _isUserOnCurrentPage && state is AuthFail
                                ? AuthLocalizationHelper.localizate(
                                    state.email,
                                    localization,
                                  )
                                : null,
                      ),
                      SelectorPasswordInputWidget(
                        placeholder: localization.passwordPlaceholder,
                        controller: _controllers[EInput.password],
                        onChanged: passwordValidate,
                        margin: EdgeInsets.only(bottom: 22.0),
                        selector: (state) =>
                            _isUserOnCurrentPage && state is AuthFail
                                ? AuthLocalizationHelper.localizate(
                                    state.password,
                                    localization,
                                  )
                                : null,
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
                        height: 40,
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
                              context.read<AuthBloc>().add(AuthGoogleSingIn());
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
