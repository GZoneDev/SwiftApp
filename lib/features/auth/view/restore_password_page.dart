import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptico/core/router/router.dart';
import 'package:receptico/generated/l10n.dart';

import '../bloc/bloc.dart';
import '../common/mixin.dart';
import '../widget/widget.dart';

@RoutePage()
class RestorePasswordPage extends StatefulWidget {
  const RestorePasswordPage({super.key});

  @override
  State<RestorePasswordPage> createState() => _RestorePasswordPageState();
}

class _RestorePasswordPageState extends State<RestorePasswordPage>
    with ShowTimerDialogueMixin, ValidateMixin {
  final _emailController = TextEditingController();

  bool _isUserOnCurrentPage = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _clearForm() => _emailController.clear();

  void _submit() {
    emailValidate(_emailController.text);

    context
        .read<AuthBloc>()
        .add(AuthRestoreEvent(email: _emailController.text));
  }

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    final localization = S.of(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        _isUserOnCurrentPage = router.current.name == RestorePasswordRoute.name;

        if (!_isUserOnCurrentPage) return;

        switch (state.runtimeType) {
          case const (AuthClearFailState):
            _clearForm();
            break;

          case const (AuthRestoreSuccessState):
            router.navigate(const SendEmailRoute());
            _clearForm();
            break;

          case const (AuthShowWaitMessageState):
            showTimedDialog(context);
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
                            SelectorTextInputWidget(
                              placeholder: localization.emailPlaceholder,
                              controller: _emailController,
                              onChanged: emailValidate,
                              margin: EdgeInsets.only(bottom: 22.0),
                              marginWithError: EdgeInsets.only(bottom: 16.0),
                              selector: (state) =>
                                  _isUserOnCurrentPage && state is AuthFailState
                                      ? state.errors[EBlocError.email]
                                      : null,
                            ),
                            SizedBox(
                              height: 50,
                              width: 278,
                              child: TextButton(
                                onPressed: _submit,
                                child: Text(localization.restorePasswordButton),
                              ),
                            ),
                            const SizedBox(height: 22),
                            GoToLinkWidget(
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
            LoadingWidget(),
          ],
        ),
      ),
    );
  }
}
