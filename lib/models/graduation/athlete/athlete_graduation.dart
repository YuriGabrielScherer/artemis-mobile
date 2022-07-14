import '../../../core/enums/enum_athlete_graduation_situation.dart';
import '../../../core/enums/enum_belt.dart';
import '../graduation.dart';
import '../professor/graduation_grade.dart';
import 'package:equatable/equatable.dart';

class AthleteGraduation extends Equatable {
  final Graduation? graduation;
  final EnumBelt belt;
  final EnumAthleteGraduationSituation situation;
  final double grade;
  final List<GraduationGrade> gradeDetail;

  String get roundedGrade => grade.toStringAsFixed(2);

  const AthleteGraduation({
    required this.graduation,
    required this.belt,
    required this.situation,
    required this.grade,
    required this.gradeDetail,
  });

  static List<AthleteGraduation> get getMock => [
        AthleteGraduation(
          graduation: Graduation.getMock.first,
          belt: EnumBelt.white,
          situation: EnumAthleteGraduationSituation.approved,
          grade: 10.0,
          gradeDetail: const [],
        ),
        AthleteGraduation(
          graduation: Graduation.getMock.last,
          belt: EnumBelt.yellow,
          situation: EnumAthleteGraduationSituation.disapproved,
          grade: 5.0,
          gradeDetail: const [],
        ),
      ];

  @override
  List<Object?> get props => [graduation, belt, situation, grade, gradeDetail];

  factory AthleteGraduation.fromMap(Map<String, dynamic> value) {
    return AthleteGraduation(
      graduation: value['graduation'] != null ? Graduation.fromMap(value['graduation']) : null,
      belt: EnumBelt.values.byName((value['belt'] as String).toLowerCase()),
      situation: EnumAthleteGraduationSituation.values.byName((value['situation'] as String).toLowerCase()),
      grade: value['grade'],
      gradeDetail: (value['gradeDetail'] as List).map((e) => GraduationGrade.fromMap(e)).toList(),
    );
  }
}
