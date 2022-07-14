import 'package:artemis_mobile/models/authentication/authentication.dart';

abstract class IAuthRepository {
  Stream<Authentication> get status;

  Future<void> login({required String username});

  void logout();

  void dispose();
}
