import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:receptico/core/FirebaseUserService/FirebaseUserManager.dart';
import 'package:receptico/features/profile/model/user.dart';
//import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FirebaseUserManager userManager;
  ProfileBloc(this.userManager) : super(ProfileInitial()) {
    on<LoadProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        // Получаем текущего пользователя
        final currentUser = userManager.getCurrentUser();
        if (currentUser == null) {
          emit(ProfileError("Пользователь не авторизован"));
          return;
        } else {
          print(currentUser.uid);
        }

        // Загружаем данные пользователя из Firebase
        final userData = await userManager.fetchUserData(currentUser.uid);

        // Эмитим состояние с загруженными данными
        emit(ProfileLoaded(userData));
      } catch (e) {
        emit(ProfileError("Ошибка загрузки профиля: $e"));
      }
      // try {
      //   // Подтянуть из БД данные об пользователе
      //   await Future.delayed(const Duration(seconds: 2));
      //   final user = UserData(
      //       name: 'John Doe',
      //       email: 'john.doe@example.com',
      //       profilePictureUrl:
      //           'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg',
      //       plan: 'Безкоштовно',
      //       uid: '',
      //       bio: '',
      //       birthday: '',
      //       gender: '',
      //       website: '');
      //   emit(ProfileLoaded(user));
      // } catch (e) {
      //   emit(ProfileError('Failed to load profile'));
      // }
    });
  }
}
