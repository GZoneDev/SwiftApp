import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptico/common/valitation/template_validate.dart';

import '../model/user.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLogin>((event, emit) {
      final LoginUser user = event.user;

      final resultEmail = TemplateValidate.emailValidate(user.email);
      final resultPassword = TemplateValidate.passwordValidate(user.password);

      AuthLoginFailure state = AuthLoginFailure();
      state.emailError = resultEmail;
      state.passwordError = resultPassword;

      if (resultEmail != null || resultPassword != null) {
        emit(state);
        return;
      }

      emit(AuthLoginSuccess());
    });

    on<AuthRegister>((event, emit) {
      final RegisterUser user = event.user;

      final resultUsername = TemplateValidate.usernameValidate(user.username);
      final resultEmail = TemplateValidate.emailValidate(user.email);
      final resultPassword = TemplateValidate.passwordValidate(user.password);
      final resultPhone = TemplateValidate.phoneValidate(user.phone);

      AuthRegisterFailure state = AuthRegisterFailure();
      state.emailError = resultEmail;
      state.passwordError = resultPassword;
      state.phoneError = resultPhone;
      state.usernameError = resultUsername;

      if (resultEmail != null ||
          resultPassword != null ||
          resultPhone != null ||
          resultUsername != null) {
        emit(state);
        return;
      }

      emit(AuthRegisterSuccess());
    });
  }
}
