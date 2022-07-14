part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthStatusChanged extends AuthEvent {
  const AuthStatusChanged(this.authentication);
  final Authentication authentication;

  @override
  List<Object> get props => [authentication];
}

class AuthLogoutRequested extends AuthEvent {}
