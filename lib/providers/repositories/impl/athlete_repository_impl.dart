import 'dart:convert';

import '../../../core/enums/enum_graduation_situation.dart';
import '../../../core/enums/enum_sort.dart';
import '../../../models/athlete/athlete.dart';
import '../../../models/graduation/athlete/athlete_graduation.dart';
import '../../../models/graduation/graduation.dart';
import '../../../models/graduation/history/graduation_history.dart';
import '../../../models/pageable/pageable_input.dart';
import '../../../models/pageable/sort_fields_input.dart';
import '../../dio_client.dart';
import '../athlete_repository.dart';
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
            SortField(property: 'graduation.date', direction: EnumSort.desc),
          ],
        ).toMap),
      },
    );

    return (response.data['records'] as List).map((e) => AthleteGraduation.fromMap(e)).toList();
  }

  @override
  Future<AthleteGraduation> getAthleteGraduation({required int athleteCode, required int graduationCode}) async {
    final Response response = await _dio.get(
      'athlete/listGraduations',
      queryParameters: {
        'athleteCode': athleteCode,
        'pageable': json.encode(const PageableInput(
          page: 0,
          size: 99,
          sortFields: [
            SortField(property: 'graduation.date', direction: EnumSort.desc),
          ],
        ).toMap),
      },
    );

    final List<AthleteGraduation> list = (response.data['records'] as List).map((e) => AthleteGraduation.fromMap(e)).toList();

    return list.firstWhere((element) => element.graduation?.code == graduationCode);
  }
}
