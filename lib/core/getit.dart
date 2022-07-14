import 'package:artemis_mobile/providers/dio_client.dart';
import 'package:artemis_mobile/providers/repositories/impl/athlete_repository_impl.dart';
import 'package:artemis_mobile/providers/repositories/impl/auth_repository_impl.dart';
import 'package:artemis_mobile/providers/repositories/impl/graduation_repository_impl.dart';
import 'package:artemis_mobile/providers/repositories/impl/person_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerSingleton(Dio());

  getIt.registerSingleton(DioClient(getIt<Dio>()));
  getIt.registerSingleton(AuthRepository(dio: getIt<DioClient>()));
  getIt.registerSingleton(PersonRepository(dio: getIt<DioClient>()));

  getIt.registerLazySingleton(() => GraduationRepository(dioClient: getIt<DioClient>()));
  getIt.registerLazySingleton(() => AthleteRepository(getIt<DioClient>()));
}
