import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/authentication/authentication.dart';
import '../../../models/person/person.dart';
import '../../../providers/repositories/auth_repository.dart';
import '../../../providers/repositories/person_repository.dart';
import '../../enums/enum_auth_status.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required IPersonRepository personRepository,
    required IAuthRepository authRepository,
  })  : _personRepository = personRepository,
        _authRepository = authRepository,
        super(const AuthState.unknown()) {
    on<AuthStatusChanged>(_onAuthStatucChanged);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    _authStatusSubscription = _authRepository.status.listen((status) => add(AuthStatusChanged(status)));
  }

  final IPersonRepository _personRepository;
  final IAuthRepository _authRepository;
  late StreamSubscription<Authentication> _authStatusSubscription;

  @override
  Future<void> close() {
    _authStatusSubscription.cancel();
    _authRepository.dispose();
    return super.close();
  }

  void _onAuthStatucChanged(AuthStatusChanged event, Emitter<AuthState> emit) async {
    switch (event.authentication.status) {
      case AuthStatus.unauthenticated:
        return emit(const AuthState.unauthenticated());
      case AuthStatus.authenticated:
        final person = await _tryGetPerson(int.parse(event.authentication.username!));
        return emit(person != null ? AuthState.authenticated(person) : const AuthState.unauthenticated());
      default:
        return emit(const AuthState.unknown());
    }
  }

  void _onAuthLogoutRequested(AuthLogoutRequested event, Emitter<AuthState> emit) async {
    _authRepository.logout();
  }

  Future<Person?> _tryGetPerson(int code) async {
    try {
      return await _personRepository.getPerson(code);
    } catch (_) {
      return null;
    }
  }
}
