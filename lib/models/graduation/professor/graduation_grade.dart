import '../../professor/professor.dart';
import 'package:equatable/equatable.dart';

class GraduationGrade extends Equatable {
  final Professor professor;
  final double grade;
  final String? description;

  String get roundedGrade => grade.toStringAsFixed(2);

  const GraduationGrade({
    required this.professor,
    required this.grade,
    this.description,
  });

  @override
  List<Object?> get props => [professor, grade, description];

  factory GraduationGrade.fromMap(Map<String, dynamic> value) {
    return GraduationGrade(
      grade: value['grade'],
      professor: Professor.fromMap(value['professor']),
      description: value['description'],
    );
  }
}
