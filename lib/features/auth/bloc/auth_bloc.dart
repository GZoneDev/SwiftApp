import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:receptico/common/valitation/template_validate.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<AuthLoginEvent>((event, emit) {
      // final resultEmailOrPhone =
      //     TemplateValidate.emailValidate(event.emailOrPhone);
      // final resultPassword = TemplateValidate.passwordValidate(event.password);

      // AuthLoginFailState state = AuthLoginFailState();
      // state.emailOrPhoneError = "resultEmailOrPhone";
      // state.passwordError = "resultPassword";

      // if (state.containsError()) {
      //   emit(state);
      //   return;
      // }

      // emit(AuthLoginSuccessState());
    });

    on<AuthRegisterEvent>((event, emit) {
      // final resultUsername = TemplateValidate.usernameValidate(event.username);
      // final resultEmailOrPhone =
      //     TemplateValidate.emailValidate(event.emailOrPhone);
      // final resultPassword = TemplateValidate.passwordValidate(event.password);

      // AuthRegisterFailState state = AuthRegisterFailState();
      // state.emailOrPhoneError = resultEmailOrPhone;
      // state.passwordError = resultPassword;
      // state.usernameError = resultUsername;

      // if (state.containsError()) {
      //   emit(state);
      //   return;
      // }

      emit(AuthRegisterSuccessState());
    });
  }
}
