import '../../../core/enums/enum_graduation_situation.dart';
import 'package:equatable/equatable.dart';

class GraduationHistory extends Equatable {
  final EnumGraduationSituation situation;
  final DateTime date;

  const GraduationHistory({required this.situation, required this.date});

  @override
  List<Object?> get props => [situation, date];

  factory GraduationHistory.fromMap(Map<String, dynamic> value) {
    return GraduationHistory(
      situation: EnumGraduationSituationExtension.fromName(value['situation']),
      date: DateTime.tryParse(value['date']) ?? DateTime.now(),
    );
  }
}
