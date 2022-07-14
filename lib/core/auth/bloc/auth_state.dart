part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState._({this.status = AuthStatus.unknown, this.person});

  const AuthState.unknown() : this._();

  const AuthState.authenticated(Person person) : this._(status: AuthStatus.authenticated, person: person);

  const AuthState.unauthenticated() : this._(status: AuthStatus.unauthenticated);

  final AuthStatus status;
  final Person? person;

  @override
  List<Object?> get props => [status, person];
}
