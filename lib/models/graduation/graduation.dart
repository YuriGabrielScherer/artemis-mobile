import '../../core/enums/enum_graduation_situation.dart';
import 'history/graduation_history.dart';
import 'package:equatable/equatable.dart';

class Graduation extends Equatable {
  final int code;
  final String title;
  final String? description;
  final String? place;
  final DateTime date;
  final EnumGraduationSituation situation;
  final List<GraduationHistory> history;

  const Graduation({
    required this.code,
    required this.title,
    this.description,
    required this.place,
    required this.date,
    required this.situation,
    required this.history,
  });

  static List<Graduation> get getMock => [
        Graduation(
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
        Graduation(
          code: 2,
          title: 'Graduação no Vasto Verde',
          description: 'Exame para atletas do ranking',
          place: 'Vasto verde',
          date: DateTime.parse('2018-05-23 00:00:00'),
          situation: EnumGraduationSituation.openSubscription,
          history: [
            GraduationHistory(
              situation: EnumGraduationSituation.created,
              date: DateTime.parse('2018-05-20 00:00:00'),
            ),
            GraduationHistory(
              situation: EnumGraduationSituation.openSubscription,
              date: DateTime.parse('2018-05-23 00:00:00'),
            ),
          ],
        ),
        Graduation(
          code: 3,
          title: 'Exame de Inverno',
          place: 'Vasto verde',
          date: DateTime.parse('2019-06-30 00:00:00'),
          situation: EnumGraduationSituation.closeSubscription,
          history: [
            GraduationHistory(
              situation: EnumGraduationSituation.created,
              date: DateTime.parse('2019-05-01 00:00:00'),
            ),
            GraduationHistory(
              situation: EnumGraduationSituation.openSubscription,
              date: DateTime.parse('2019-05-10 00:00:00'),
            ),
            GraduationHistory(
              situation: EnumGraduationSituation.closeSubscription,
              date: DateTime.parse('2019-05-20 00:00:00'),
            ),
          ],
        ),
        Graduation(
          code: 4,
          title: 'Exame de Inverno para mulheres',
          place: 'Yokohama',
          date: DateTime.parse('2020-06-30 00:00:00'),
          situation: EnumGraduationSituation.openSubscription,
          history: [
            GraduationHistory(
              situation: EnumGraduationSituation.created,
              date: DateTime.parse('2020-05-10 00:00:00'),
            ),
            GraduationHistory(
              situation: EnumGraduationSituation.openSubscription,
              date: DateTime.parse('2020-05-20 00:00:00'),
            ),
          ],
        ),
        Graduation(
          code: 5,
          title: 'Exame de verão',
          description: 'Descrição do Exame de Verão',
          place: 'Floripa',
          date: DateTime.parse('2021-06-08 00:00:00'),
          situation: EnumGraduationSituation.canceled,
          history: [
            GraduationHistory(
              situation: EnumGraduationSituation.created,
              date: DateTime.parse('2021-05-10 00:00:00'),
            ),
            GraduationHistory(
              situation: EnumGraduationSituation.openSubscription,
              date: DateTime.parse('2021-05-12 00:00:00'),
            ),
            GraduationHistory(
              situation: EnumGraduationSituation.canceled,
              date: DateTime.parse('2021-05-25 00:00:00'),
            ),
          ],
        ),
        Graduation(
          code: 6,
          title: 'Exame de Graduação para Yokohama',
          place: 'Yokohama',
          date: DateTime.parse('2022-06-29 00:00:00'),
          situation: EnumGraduationSituation.created,
          history: [
            GraduationHistory(
              situation: EnumGraduationSituation.created,
              date: DateTime.parse('2022-06-20 00:00:00'),
            ),
          ],
        ),
      ];

  @override
  List<Object?> get props => [
        code,
        title,
        description,
        place,
        date,
        situation,
        history,
      ];

  factory Graduation.fromMap(Map<String, dynamic> value) {
    return Graduation(
      code: value['code'],
      title: value['title'],
      description: value['description'],
      date: DateTime.tryParse(value['date']) ?? DateTime.now(),
      place: value['place'],
      situation: EnumGraduationSituationExtension.fromName(value['situation']),
      history: (value['history'] as List<dynamic>).map((history) => GraduationHistory.fromMap(history)).toList(),
    );
  }
}
