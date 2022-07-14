import 'dart:async';

import 'package:artemis_mobile/core/enums/enum_auth_status.dart';
import 'package:artemis_mobile/models/authentication/authentication.dart';
import 'package:artemis_mobile/providers/dio_client.dart';
import 'package:artemis_mobile/providers/repositories/auth_repository.dart';
import 'package:dio/dio.dart';

class AuthRepository implements IAuthRepository {
  final DioClient _dio;
  final _controller = StreamController<Authentication>();

  AuthRepository({required DioClient dio}) : _dio = dio;

  @override
  Stream<Authentication> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield const Authentication(status: AuthStatus.unauthenticated);
    yield* _controller.stream;
  }

  @override
  Future<void> login({required String username}) async {
    try {
      final Response response = await _dio.get('person/$username');
      _controller.add(Authentication(status: AuthStatus.authenticated, username: username));
    } catch (e) {
      rethrow;
    }
  }

  @override
  void logout() {
    _controller.add(const Authentication(status: AuthStatus.unauthenticated));
  }

  @override
  void dispose() => _controller.close();
}
