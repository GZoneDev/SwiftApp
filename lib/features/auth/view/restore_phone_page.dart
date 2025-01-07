import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptico/core/router/router.dart';
import 'package:receptico/generated/l10n.dart';
import 'package:receptico/core/UI/theme.dart';

import '../bloc/bloc.dart';
import '../common/enum.dart';
import '../widget/widget.dart';

@RoutePage()
class RestorePhonePage extends StatefulWidget {
  const RestorePhonePage({super.key});

  @override
  State<RestorePhonePage> createState() => _RestorePhonePageState();
}

class _RestorePhonePageState extends State<RestorePhonePage> {
  final Map<EInput, TextEditingController> _controllers = {
    EInput.smsCode: TextEditingController(),
    EInput.password: TextEditingController(),
    EInput.confirmPassword: TextEditingController(),
  };

  void _clearForm() =>
      _controllers.forEach((key, controller) => controller.clear());

  @override
  void dispose() {
    _controllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  String? _smsCodeValidate(String? value) {
    context.read<AuthBloc>().add(
          AuthSMSCodeValidateEvent(
            value: value,
            localization: S.of(context),
          ),
        );
    return value;
  }

  String? _passwordValidate(String? value) {
    _confirmPasswordValidate(_controllers[EInput.confirmPassword]?.text);
    context.read<AuthBloc>().add(
          AuthPasswordValidateEvent(
            value: value,
            localization: S.of(context),
          ),
        );
    return value;
  }

  String? _confirmPasswordValidate(String? value) {
    context.read<AuthBloc>().add(
          AuthConfirmPasswordValidateEvent(
            value: _controllers[EInput.password]?.text,
            confirmValue: value,
            localization: S.of(context),
          ),
        );
    return value;
  }

  void _submit() {
    _smsCodeValidate(_controllers[EInput.smsCode]?.text);
    _passwordValidate(_controllers[EInput.password]?.text);
    _confirmPasswordValidate(_controllers[EInput.confirmPassword]?.text);

    context.read<AuthBloc>().add(
          AuthRestorePhoneEvent(
            code: _controllers[EInput.smsCode]?.text ?? '',
            password: _controllers[EInput.password]?.text ?? '',
            confirmPassword: _controllers[EInput.confirmPassword]?.text ?? '',
            localization: S.of(context),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    final localization = S.of(context);
    return WillPopScope(
      onWillPop: () async {
        context.read<AuthBloc>().add(AuthRouteEvent());
        return true;
      },
      child: Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            // if (state is AuthLoginFailState) {
            //   //_isError = true;
            //   //setState(() => _authState = state);
            // }
          },
          child: Stack(
            children: [
              const ScreenBackgroundWidget(),
              Container(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 350,
                  height: 500,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TitleWidget(
                          title: localization.restorePasswordTitle,
                          subtitle: localization.smsSubtitle,
                        ),
                        const SizedBox(height: 37),
                        SizedBox(
                          width: 278,
                          child: Column(
                            children: [
                              PhoneWidget(text: '+380********98'),
                              SelectorTextInputWidget(
                                placeholder: localization.smsCodePlaceholder,
                                controller: _controllers[EInput.smsCode],
                                selector: (state) =>
                                    state.errors?[EBlocError.smsCode],
                                onChanged: _smsCodeValidate,
                              ),
                              SelectorPasswordInputWidget(
                                placeholder: localization.passwordPlaceholder,
                                controller: _controllers[EInput.password],
                                selector: (state) =>
                                    state.errors?[EBlocError.password],
                                onChanged: _passwordValidate,
                                margin: EdgeInsets.only(bottom: 16.0),
                                marginWithError: EdgeInsets.only(bottom: 10.0),
                              ),
                              SelectorPasswordInputWidget(
                                placeholder:
                                    localization.confirmPasswordPlaceholder,
                                controller:
                                    _controllers[EInput.confirmPassword],
                                selector: (state) =>
                                    state.errors?[EBlocError.confirmPassword],
                                onChanged: _confirmPasswordValidate,
                                margin: EdgeInsets.only(bottom: 28.0),
                              ),
                              TextButtonWidget(
                                height: 50,
                                text: localization.confirmPasswordChangeButton,
                                onPressed: _submit,
                              ),
                              const SizedBox(height: 28),
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

class PhoneWidget extends StatelessWidget {
  final String text;
  final double height;
  final EdgeInsets margin;

  const PhoneWidget({
    super.key,
    required this.text,
    this.height = 42,
    this.margin = const EdgeInsets.only(bottom: 16),
  });

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.symmetric(horizontal: 16, vertical: 8);
    return Container(
      height: height,
      width: double.infinity,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: context.color.background.dashboarPhone.safe,
        border: Border.all(
          color: context.color.border.dashboarPhone.safe,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: context.font.body?.copyWith(
          color: context.color.font.input.safe,
        ),
      ),
    );
  }
}
