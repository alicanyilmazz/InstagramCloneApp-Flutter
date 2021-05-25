import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../models/failure_model.dart';
import '../../../repositories/auth/auth_repository.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository _authRepository;

  SignupCubit({@required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(SignupState.initial());

  void usernameChanged(String value) {
    emit(state.copyWith(username: value, status: SignupStatus.inital));
  }

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: SignupStatus.inital));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: SignupStatus.inital));
  }

  void signUpWithCredentials() async {
    if (!state.isFormValid || state.status == SignupStatus.submitting) {
      return;
    }
    emit(state.copyWith(status: SignupStatus.submitting));
    try {
      await _authRepository.signUpWithEmailAndPassword(
          username: state.username,
          email: state.email,
          password: state.password);
      emit(state.copyWith(status: SignupStatus.success));
    } on Failure catch (err) {
      emit(state.copyWith(failure: err, status: SignupStatus.error));
    }
  }
}
