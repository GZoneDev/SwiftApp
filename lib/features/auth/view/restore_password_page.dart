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
  final _emailOrPhoneController = TextEditingController();

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    super.dispose();
  }

  void _clearForm() => _emailOrPhoneController.clear();

  String? _emailOrPhoneValidate(String? value) {
    context.read<AuthBloc>().add(
          AuthEmailValidateEvent(
            value: value,
            localization: S.of(context),
          ),
        );
    return value;
  }

  void _submit() {
    _emailOrPhoneValidate(_emailOrPhoneController.text);

    context.read<AuthBloc>().add(
          AuthRestoreEvent(
            emailOrPhone: _emailOrPhoneController.text,
            localization: S.of(context),
            router: AutoRouter.of(context),
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

          case const (AuthRestoreSuccessState):
            router.navigate(const SendEmailRoute());
            _clearForm();
            break;
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          context.read<AuthBloc>().add(AuthRouteEvent());
          return true;
        },
        child: Scaffold(
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
                                selector: (state) =>
                                    state.errors?[EBlocError.email],
                                controller: _emailOrPhoneController,
                                onChanged: _emailOrPhoneValidate,
                                margin: EdgeInsets.only(bottom: 22.0),
                                marginWithError: EdgeInsets.only(bottom: 16.0),
                              ),
                              TextButtonWidget(
                                height: 50,
                                text: localization.restorePasswordButton,
                                onPressed: _submit,
                              ),
                              const SizedBox(height: 22),
                              BackLinkWidget(
                                text: localization.returnToLoginLink,
                                onTap: () {
                                  router.navigate(const LoginRoute());
                                  context
                                      .read<AuthBloc>()
                                      .add(AuthRouteEvent());
                                },
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
      ),
    );
  }
}
