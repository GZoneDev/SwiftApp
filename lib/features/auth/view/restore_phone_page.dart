import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptico/core/UI/color/color_theme.dart';
import 'package:receptico/core/UI/font/font_theme.dart';
import 'package:receptico/core/router/router.dart';
import 'package:receptico/generated/l10n.dart';

import '../bloc/bloc.dart';
import '../widget/widget.dart';

@RoutePage()
class RestorePhonePage extends StatefulWidget {
  const RestorePhonePage({super.key});

  @override
  State<RestorePhonePage> createState() => _RestorePhonePageState();
}

class _RestorePhonePageState extends State<RestorePhonePage> {
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
      setState(() => _authState = AuthLoginFailState());
    }
  }

  void _submit() {}

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
                            TextInputWidget(
                              controller: _emailOrPhoneController,
                              placeholder: localization.smsCodePlaceholder,
                              onTap: _clearFailMessage,
                              errorMessage: _authState.emailOrPhoneError,
                              margin: EdgeInsets.only(bottom: 16.0),
                              marginWithError: EdgeInsets.only(bottom: 10.0),
                            ),
                            TextInputWidget(
                              controller: _emailOrPhoneController,
                              placeholder: localization.newPasswordPlaceholder,
                              onTap: _clearFailMessage,
                              errorMessage: _authState.emailOrPhoneError,
                              margin: EdgeInsets.only(bottom: 16.0),
                              marginWithError: EdgeInsets.only(bottom: 10.0),
                            ),
                            TextInputWidget(
                              controller: _emailOrPhoneController,
                              placeholder:
                                  localization.confirmPasswordPlaceholder,
                              onTap: _clearFailMessage,
                              errorMessage: _authState.emailOrPhoneError,
                              margin: EdgeInsets.only(bottom: 25.0),
                              marginWithError: EdgeInsets.only(bottom: 22.0),
                            ),
                            TextButtonWidget(
                              height: 50,
                              text: localization.confirmPasswordChangeButton,
                              onPressed: () => router.navigate(
                                  const RestorePhoneRoute()), //_submit,
                            ),
                            const SizedBox(height: 28),
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
        color: context.color.background.dashboarPhone,
        border: Border.all(
          color: context.color.border.dashboarPhone.safe,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: context.font.body?.copyWith(
          color: context.color.font.input,
        ),
      ),
    );
  }
}
