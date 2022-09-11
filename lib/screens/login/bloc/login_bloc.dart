import '../../../providers/repositories/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required IAuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  final IAuthRepository _authRepository;

  void _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    if (int.parse(event.username) <= 0) {
      emit(const LoginError(error: 'Usuário inválido.'));
    }

    try {
      await _authRepository.login(username: event.username);
    } catch (_) {
      emit(const LoginError(error: 'Usuário e/ou senha incorretos.'));
    }
  }
}
