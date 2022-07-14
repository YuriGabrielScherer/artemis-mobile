import 'dart:convert';

import 'package:artemis_mobile/core/enums/enum_graduation_situation.dart';
import 'package:artemis_mobile/core/enums/enum_sort.dart';
import 'package:artemis_mobile/models/athlete/athlete.dart';
import 'package:artemis_mobile/models/graduation/athlete/athlete_graduation.dart';
import 'package:artemis_mobile/models/graduation/graduation.dart';
import 'package:artemis_mobile/models/graduation/history/graduation_history.dart';
import 'package:artemis_mobile/models/pageable/pageable_input.dart';
import 'package:artemis_mobile/models/pageable/sort_fields_input.dart';
import 'package:artemis_mobile/providers/dio_client.dart';
import 'package:artemis_mobile/providers/repositories/athlete_repository.dart';
import 'package:dio/dio.dart';

class AthleteRepository implements IAthleteRepository {
  const AthleteRepository(DioClient dio) : _dio = dio;

  final DioClient _dio;

  @override
  Future<Graduation> getGraduation(int athleteCode) {
    return Future.delayed(
      const Duration(seconds: 1),
      () => Graduation(
        code: 1,
        title: 'Exame de Graduação de Cocal do Sul',
        description: 'apenas para os atletas selecionados',
        place: 'Cocal do Sul',
        date: DateTime.parse('2022-12-25 00:00:00'),
        situation: EnumGraduationSituation.created,
        history: [
          GraduationHistory(
            situation: EnumGraduationSituation.created,
            date: DateTime.parse('2022-12-25 00:00:00'),
          ),
        ],
      ),
    );
  }

  @override
  Future<Athlete> getAthlete(int athleteCode) async {
    final Response response = await _dio.get('athlete/$athleteCode');
    return Athlete.fromMap(response.data);
  }

  @override
  Future<List<AthleteGraduation>> listGraduations(int athleteCode) async {
    final Response response = await _dio.get(
      'athlete/listGraduations',
      queryParameters: {
        'athleteCode': athleteCode,
        'pageable': json.encode(const PageableInput(
          page: 0,
          size: 99,
          sortFields: [
            SortField(property: 'graduation.date', direction: EnumSort.asc),
          ],
        ).toMap),
      },
    );

    return (response.data['records'] as List).map((e) => AthleteGraduation.fromMap(e)).toList();
  }
}
