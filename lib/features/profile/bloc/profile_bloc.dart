import 'package:bloc/bloc.dart';
//import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<LoadProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        // Mocking user data
        await Future.delayed(const Duration(seconds: 2));
        final user = User(
            name: 'John Doe',
            email: 'john.doe@example.com',
            profilePictureUrl:
                'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg',
            plan: 'Безкоштовно');
        emit(ProfileLoaded(user));
      } catch (e) {
        emit(ProfileError('Failed to load profile'));
      }
    });
  }
}
