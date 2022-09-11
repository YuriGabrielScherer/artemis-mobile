import '../../dio_client.dart';
import 'package:dio/dio.dart';

import '../../../models/person/person.dart';
import '../person_repository.dart';

class PersonRepository implements IPersonRepository {
  const PersonRepository({required DioClient dio}) : _dio = dio;

  final DioClient _dio;

  @override
  Future<Person?> getPerson(int code) async {
    try {
      final Response response = await _dio.get('person/$code');
      return Person.fromMap(response.data);
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
