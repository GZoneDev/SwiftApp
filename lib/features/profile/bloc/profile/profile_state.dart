part of 'profile_bloc.dart';

// class User {
//   final String name;
//   final String email;
//   final String profilePictureUrl;
//   final String plan;

//   User({
//     this.name = 'Unknown',
//     this.email = 'No email',
//     this.profilePictureUrl = '',
//     this.plan = 'Безкоштовно',
//   });
// }

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserData user;
  ProfileLoaded(this.user);
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
