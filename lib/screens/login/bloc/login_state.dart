part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginError extends LoginState {
  const LoginError({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

class LoginLoading extends LoginState {}
