import 'package:artemis_mobile/core/enums/enum_auth_status.dart';

class Authentication {
  const Authentication({required this.status, this.username});

  final AuthStatus status;
  final String? username;
}
