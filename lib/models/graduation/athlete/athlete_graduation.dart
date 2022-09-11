import 'package:artemis_mobile/models/graduation/athlete/file/athlete_graduation_file.dart';
import 'package:artemis_mobile/models/graduation/athlete/history/athlete_graduation_history.dart';

import '../../../core/enums/enum_athlete_graduation_situation.dart';
import '../../../core/enums/enum_belt.dart';
import '../graduation.dart';
import '../professor/graduation_grade.dart';
import 'package:equatable/equatable.dart';

class AthleteGraduation extends Equatable {
  final Graduation? graduation;
  final EnumBelt belt;
  final EnumAthleteGraduationSituation situation;
  final List<AthleteGraduationHistory> history;
  final double grade;
  final List<GraduationGrade> gradeDetail;
  final AthleteGraduationFile? file;

  String get roundedGrade => grade.toStringAsFixed(2);

  const AthleteGraduation({
    required this.graduation,
    required this.belt,
    required this.situation,
    required this.grade,
    required this.gradeDetail,
    required this.history,
    this.file,
  });

  @override
  List<Object?> get props => [graduation, belt, situation, grade, gradeDetail, file];

  factory AthleteGraduation.fromMap(Map<String, dynamic> value) {
    return AthleteGraduation(
      graduation: value['graduation'] != null ? Graduation.fromMap(value['graduation']) : null,
      belt: EnumBelt.values.byName((value['belt'] as String).toLowerCase()),
      situation: EnumAthleteGraduationSituationExtesion.fromName(value['situation']),
      grade: value['grade'],
      gradeDetail: (value['gradeDetail'] as List).map((e) => GraduationGrade.fromMap(e)).toList(),
      history: (value['history'] as List).map((e) => AthleteGraduationHistory.fromMap(e)).toList(),
      file: value['file'] != null ? AthleteGraduationFile.fromMap(value['file']) : null,
    );
  }
}
