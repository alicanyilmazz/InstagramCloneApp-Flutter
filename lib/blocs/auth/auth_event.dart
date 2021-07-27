part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [];
}

/// This event is going to be called whenever Firebase updates the current user that's signed in.
class AuthUserChanged extends AuthEvent {
  final auth.User? user;

  const AuthUserChanged({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthLogoutRequested extends AuthEvent {}
