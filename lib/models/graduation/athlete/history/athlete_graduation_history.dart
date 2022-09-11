import 'package:artemis_mobile/core/enums/enum_athlete_graduation_situation.dart';
import 'package:equatable/equatable.dart';

class AthleteGraduationHistory extends Equatable {
  final EnumAthleteGraduationSituation situation;
  final String createdBy;
  final DateTime createdDate;
  final String? lastModifiedBy;
  final DateTime? lastModifiedDate;

  const AthleteGraduationHistory({
    required this.situation,
    required this.createdBy,
    required this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
  });

  @override
  List<Object?> get props => [situation, createdBy, createdDate, lastModifiedBy, lastModifiedDate];

  factory AthleteGraduationHistory.fromMap(Map<String, dynamic> value) {
    return AthleteGraduationHistory(
      situation: EnumAthleteGraduationSituationExtesion.fromName(value['situation']),
      createdBy: value['createdBy'],
      createdDate: DateTime.parse(value['createdDate']),
      lastModifiedBy: value['lastModifiedBy'],
      lastModifiedDate: DateTime.tryParse(value['lastModifiedDate']),
    );
  }
}
