part of 'login_cubit.dart';

enum LoginStatus { inital, submitting, success, error }

class LoginState extends Equatable {
  final String email;
  final String password;
  final LoginStatus status;
  final Failure failure;

  const LoginState({this.email, this.password, this.status, this.failure});

  factory LoginState.initial() {
    return LoginState(
      email: '',
      password: '',
      status: LoginStatus.inital,
      failure: const Failure(),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [email, password, status, failure];
}
