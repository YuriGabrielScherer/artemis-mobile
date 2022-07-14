import 'dart:convert';

import 'package:artemis_mobile/models/pageable/pageable_input.dart';
import 'package:artemis_mobile/providers/dio_client.dart';
import 'package:dio/dio.dart';

import '../../../models/pageable/pageable.dart';
import '../../../models/graduation/graduation.dart';
import '../graduation_repository.dart';

class GraduationRepository implements IGraduationRepository {
  const GraduationRepository({required DioClient dioClient}) : _dio = dioClient;
  final DioClient _dio;

  @override
  Future<Pageable<Graduation>> list({required PageableInput pageableInput}) async {
    final Response response = await _dio.get(
      'graduation/list',
      queryParameters: {
        'pageable': json.encode(pageableInput.toMap),
      },
    );

    return Pageable<Graduation>(
      totalRecords: response.data['totalRecords'],
      records: (response.data['records'] as List<dynamic>).map((grad) => Graduation.fromMap(grad)).toList(),
    );
  }
}
