import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/bloc/auth/auth_events.dart';
import 'package:flutter_login/bloc/auth/auth_states.dart';
import '../../data/repository/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc(this.repository) : super(AuthInitial()) {
    on<LoginRequested>(_onLogin);
    on<SignUpRequested>(_onSignUp);
  }

  Future<void> _onLogin(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final authResponse = await repository.login(event.email, event.password);

      debugPrint('API SUCCESS → token: ${authResponse.token}');

      if (authResponse.isSuccess) {
        emit(AuthSuccess(authResponse.token!));
      } else {
        emit(AuthFailure(authResponse.error ?? 'Login failed'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onSignUp(SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final authResponse = await repository.signUp(event.email, event.password);

      if (authResponse.isSuccess) {
        emit(AuthSuccess(authResponse.token!));
        return;
      } else {
        emit(AuthFailure('Sign Up failed'));
        return;
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
